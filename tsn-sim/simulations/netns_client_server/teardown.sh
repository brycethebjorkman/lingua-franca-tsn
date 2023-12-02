# destroy TAP interface
nsenter --net=/run/netns/ns1 ip tuntap del mode tap dev tap1
nsenter --net=/run/netns/ns2 ip tuntap del mode tap dev tap2

# remove network namespace
ip netns del ns1
ip netns del ns2
