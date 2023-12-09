#!/bin/bash
#
# clean up system changes made by setup script

num_hosts=120

# destroy interfaces
num=1
while [ $num -le $num_hosts ]
do
    nsenter --net="/run/netns/ns$num" ip tuntap del mode tap dev "tap$num"
    ((num++))
done

# destroy network namespaces
num=1
while [ $num -le $num_hosts ]
do
    ip netns del "ns$num"
    ((num++))
done

