# start simulation

# # some variation of this should be workable as an alternative to calling the executable OMNeT++ generates in the src directory
# inet -u Cmdenv \
#        -f $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations/basic_federation/omnetpp.ini \
#        -n $LINGUA_FRANCA_TSN_ROOT/tsn-sim/simulations \
#        &

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

stdbuf -i 0 -o 0 -e 0 \
    bin/BasicFederation_distribute.sh

stdbuf -i 0 -o 0 -e 0 \
    bin/BasicFederation

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
