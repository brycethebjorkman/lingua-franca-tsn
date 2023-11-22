# test simulation

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

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/rti_serve_p.py" &

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/rti_serve_c.py" &

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/federate_p_serve_c.py" &

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/federate_p_client_rti.py" &

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/federate_c_client_rti.py" &

python3 "$LINGUA_FRANCA_TSN_ROOT/src/basic-federation/test/federate_c_client_p.py"

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
