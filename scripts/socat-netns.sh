#!/bin/bash
#
# runs a socat file transfer over the veth between network namespaces

# create interfaces
ip link add dev veth1 type veth peer name veth1_ns1

# create network namespace
ip netns add ns1

# move interface to network namespace
ip link set veth1_ns1 netns ns1

# assign ip addresses to interfaces
subnet1="192.168.2"
ip_veth1="$subnet1.1"
ip_veth1_ns1="$subnet1.2"

ip addr add "$ip_veth1"/24 dev veth1
nsenter --net=/run/netns/ns1 ip addr add "$ip_veth1_ns1"/24 dev veth1_ns1

# bring up interfaces
ip link set veth1 up
nsenter --net=/run/netns/ns1 ip link set dev veth1_ns1 up

mkdir results

i=1
while [ $i -le 2500 ]
do
    echo "Data: $i" >> results/data.txt
    ((i++))
done

duration=30
dumpcap -i lo -a duration:$duration -w results/lo.pcap -p &
dumpcap -i veth1 -a duration:$duration -w results/veth1.pcap -p &
nsenter --net=/run/netns/ns1 dumpcap -i veth1_ns1 -a duration:$duration -w results/veth1_ns1.pcap -p &
dumpcap_pid=$!

socat -u TCP-LISTEN:12345,bind="$ip_veth1",reuseaddr OPEN:results/socat-listen.log,creat,append &
nsenter --net=/run/netns/ns1 socat -u FILE:results/data.txt TCP:"$ip_veth1":12345

wait "$dumpcap_pid"
