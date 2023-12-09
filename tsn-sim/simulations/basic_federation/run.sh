#!/bin/bash

# start simulation

# # some variation of this should be workable as an alternative to calling the executable OMNeT++ generates in the src directory
# inet -u Cmdenv \
#        -f $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/basic_federation/omnetpp.ini \
#        -n $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations \
#        &

pushd /root > /dev/null
mkdir -p LinguaFrancaRemote/fed-gen/BasicFederation/src-gen/federate__c/core LinguaFrancaRemote/bin LinguaFrancaRemote/log
mkdir -p LinguaFrancaRemote/fed-gen/BasicFederation/src-gen/federate__p/core LinguaFrancaRemote/bin LinguaFrancaRemote/log
cp /usr/app/fed-gen/BasicFederation/bin/federate__c /root/LinguaFrancaRemote/bin/BasicFederation_federate__c
cp /usr/app/fed-gen/BasicFederation/bin/federate__p /root/LinguaFrancaRemote/bin/BasicFederation_federate__p
popd > /dev/null

mkdir -p results

dumpcap -i lo -a duration:120 -w results/lo.pcap -p &
dumpcap -i tap_l -a duration:120 -w results/tap_l.pcap -p &
nsenter --net=/run/netns/ns_r dumpcap -i tap_r -a duration:120 -w results/tap_r.pcap -p &
nsenter --net=/run/netns/ns_c dumpcap -i tap_c -a duration:120 -w results/tap_c.pcap -p &
nsenter --net=/run/netns/ns_p dumpcap -i tap_p -a duration:120 -w results/tap_p.pcap -p &

$LINGUA_FRANCA_TSN_ROOT/tsn-sim/src/tsn-sim -m \
    -n $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations \
    -n $LINGUA_FRANCA_TSN_ROOT/tsn-sim/src \
    -n $INET_ROOT/examples \
    -n $INET_ROOT/showcases \
    -n $INET_ROOT/src \
    -n $INET_ROOT/tests/validation \
    -n $INET_ROOT/tests/networks \
    -n $INET_ROOT/tutorials \
    -x inet.common.selfdoc \
    -x inet.linklayer.configurator.gatescheduling.z3 \
    -x inet.showcases.visualizer.osg \
    -x inet.examples.emulation \
    -x inet.transportlayer.tcp_lwip \
    -x inet.showcases.emulation \
    -x inet.applications.voipstream \
    -x inet.visualizer.osg \
    -x inet.examples.voipstream \
    --image-path=$INET_ROOT/images \
    -l $INET_ROOT/src/INET \
    $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/basic_federation/omnetpp.ini \
    &
tsn_sim_pid=$!

/usr/sbin/sshd -f /etc/ssh/sshd_config.d/localhost.conf
nsenter --net=/run/netns/ns_r /usr/sbin/sshd -f /etc/ssh/sshd_config.d/rti.conf
nsenter --net=/run/netns/ns_c /usr/sbin/sshd -f /etc/ssh/sshd_config.d/federate_c.conf
nsenter --net=/run/netns/ns_p /usr/sbin/sshd -f /etc/ssh/sshd_config.d/federate_p.conf

sleep 1

FEDERATION_ID=`openssl rand -hex 24`
log_dir=$(realpath results)/log

mkdir -p "$log_dir"

r_log="$log_dir/BasicFederation_RTI.log"
ssh 192.168.2.2 '\
    echo "-------------- Federation ID: "'$FEDERATION_ID' >> '$r_log'; \
    date >> '$r_log'; \
    stdbuf -i 0 -o 0 -e 0 \
    RTI -i '$FEDERATION_ID' -n 2 -c init exchanges-per-interval 10 \
    2>&1 | tee -a '$r_log'' &

sleep 1

c_log="$log_dir/BasicFederation_federate__c.log"
ssh 192.168.2.3 '\
    cd LinguaFrancaRemote; \
    echo "-------------- Federation ID: "'$FEDERATION_ID' >> '$c_log'; \
    date >> '$c_log'; \
    bin/BasicFederation_federate__c -i '$FEDERATION_ID' \
    2>&1 | tee -a '$c_log'' &

p_log="$log_dir/BasicFederation_federate__p.log"
ssh 192.168.2.4 '\
    cd LinguaFrancaRemote; \
    echo "-------------- Federation ID: "'$FEDERATION_ID' >> '$p_log'; \
    date >> '$p_log'; \
    bin/BasicFederation_federate__p -i '$FEDERATION_ID' \
    2>&1 | tee -a '$p_log'' &

#stdbuf -i 0 -o 0 -e 0 \
#    bin/BasicFederation_distribute.sh

#stdbuf -i 0 -o 0 -e 0 \
#    bin/BasicFederation

wait "$tsn_sim_pid"

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
