#!/bin/bash
#
# start simulation

mkdir results

duration=120
num_hosts=120

# start packet capture processes
dumpcap -i lo -a duration:$duration -w results/lo.pcap -p &
num=1
while [ $num -le $num_hosts ]
do
    nsenter --net="/run/netns/ns$num" dumpcap -i "tap$num" -a duration:$duration -w "results/tap$num.pcap" -p &
    ((num++))
done

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
    $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/star_tree/omnetpp.ini \
    &
tsn_sim_pid=$!

# start SSH servers
num=1
while [ $num -le $num_hosts ]
do
    nsenter --net="/run/netns/ns$num" /usr/sbin/sshd -f "/etc/ssh/sshd_config.d/host$num.conf"
    ((num++))
done

wait "$tsn_sim_pid"

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
