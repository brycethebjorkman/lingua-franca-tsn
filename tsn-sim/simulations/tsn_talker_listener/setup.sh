# create interfaces
ip tuntap add mode tap dev tap1
ip tuntap add mode tap dev tap2

# create network namespaces
ip netns add ns1
ip netns add ns2

# move interfaces to network namespaces
ip link set tap1 netns ns1
ip link set tap2 netns ns2

# bring up interfaces
nsenter --net=/run/netns/ns1 ip link set dev tap1 up
nsenter --net=/run/netns/ns2 ip link set dev tap2 up

# assign IP addresses to interfaces
ip_tap1="192.168.2.1"
ip_tap2="192.168.2.2"

nsenter --net=/run/netns/ns1 ip addr add "$ip_tap1"/24 dev tap1
nsenter --net=/run/netns/ns2 ip addr add "$ip_tap2"/24 dev tap2
