# start simulation
inet -u Cmdenv -f omnetpp.ini -n .

# kill child processes
trap 'kill $(jobs -pr)' SIGINT SIGTERM EXIT
