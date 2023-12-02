# start simulation

echo -e "\n\n\n Starting socat_netns simulation...\n\n"

mkdir results

i=1
while [ $i -le 2500 ]
do
    echo "Data: $i" >> results/data.txt
    ((i++))
done

dumpcap -i lo -a duration:100 -w results/lo.pcap -p &
nsenter --net=/run/netns/ns1 dumpcap -i tap1 -a duration:100 -w results/ns1_tap1.pcap -p &
nsenter --net=/run/netns/ns2 dumpcap -i tap2 -a duration:100 -w results/ns2_tap2.pcap -p &

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
    $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/socat_netns/omnetpp.ini \
    &
tsn_sim_pid=$!

sleep 5
nsenter --net=/run/netns/ns2 \
socat -u TCP-LISTEN:12345,bind=192.168.2.21,reuseaddr OPEN:results/socat-listen.log,creat,append &

sleep 1
nsenter --net=/run/netns/ns1 \
socat -u FILE:results/data.txt TCP:192.168.2.21:12345

wait "$tsn_sim_pid"

# kill child processes on exit
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
