# start simulation

echo "\n\n\n Starting tsn_talker_listener simulation...\n\n"

mkdir results

dumpcap -i lo -a duration:100 -w results/lo.pcap -p &
nsenter --net=/run/netns/ns1 \
dumpcap -i tap1 -a duration:100 -w results/tap1.pcap -p &
nsenter --net=/run/netns/ns2 \
dumpcap -i tap2 -a duration:100 -w results/tap2.pcap -p &

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
    $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/tsn_talker_listener/omnetpp.ini \
    &
tsn_sim_pid=$!

nsenter --net=/run/netns/ns2 \
python3 $LINGUA_FRANCA_TSN_ROOT/src/talker-listener/listener.py --host 192.168.2.2 -p 4000 &

nsenter --net=/run/netns/ns1 \
python3 $LINGUA_FRANCA_TSN_ROOT/src/talker-listener/talker.py --host 192.168.2.2 -p 4000 &

wait "$tsn_sim_pid"

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
