#!/bin/bash

# create tap interface
ip tuntap add dev tap1 mode tap
ip tuntap add dev tap2 mode tap

# create network namespace
ip netns add ns1
ip netns add ns2

# move tap to network namespace
ip link set tap1 netns ns1
ip link set tap2 netns ns2

# bring up tap
nsenter --net=/run/netns/ns1 ip link set dev tap1 up
nsenter --net=/run/netns/ns2 ip link set dev tap2 up

# assign IP address to tap
nsenter --net=/run/netns/ns1 ip addr add 192.168.2.20/24 dev tap1
nsenter --net=/run/netns/ns2 ip addr add 192.168.3.20/24 dev tap2
