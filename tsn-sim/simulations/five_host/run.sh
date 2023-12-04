#!/bin/bash
#
# start simulation

mkdir results

duration=120
dumpcap -i lo -a duration:$duration -w results/lo.pcap -p &
nsenter --net=/run/netns/ns1 dumpcap -i tap1 -a duration:$duration -w results/tap1.pcap -p &
nsenter --net=/run/netns/ns2 dumpcap -i tap2 -a duration:$duration -w results/tap2.pcap -p &
nsenter --net=/run/netns/ns3 dumpcap -i tap3 -a duration:$duration -w results/tap3.pcap -p &
nsenter --net=/run/netns/ns4 dumpcap -i tap4 -a duration:$duration -w results/tap4.pcap -p &
nsenter --net=/run/netns/ns5 dumpcap -i tap5 -a duration:$duration -w results/tap5.pcap -p &

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
    $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/five_host/omnetpp.ini \
    &
tsn_sim_pid=$!

nsenter --net=/run/netns/ns1 /usr/sbin/sshd -f /etc/ssh/sshd_config.d/host1.conf
nsenter --net=/run/netns/ns2 /usr/sbin/sshd -f /etc/ssh/sshd_config.d/host2.conf
nsenter --net=/run/netns/ns3 /usr/sbin/sshd -f /etc/ssh/sshd_config.d/host3.conf
nsenter --net=/run/netns/ns4 /usr/sbin/sshd -f /etc/ssh/sshd_config.d/host4.conf
nsenter --net=/run/netns/ns5 /usr/sbin/sshd -f /etc/ssh/sshd_config.d/host5.conf

wait "$tsn_sim_pid"

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
