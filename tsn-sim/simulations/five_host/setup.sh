#!/bin/bash
#
# configure network and SSH

# create interfaces
ip tuntap add mode tap dev tap1
ip tuntap add mode tap dev tap2
ip tuntap add mode tap dev tap3
ip tuntap add mode tap dev tap4
ip tuntap add mode tap dev tap5

# create network namespaces
ip netns add ns1
ip netns add ns2
ip netns add ns3
ip netns add ns4
ip netns add ns5

# move interfaces to network namespaces
ip link set tap1 netns ns1
ip link set tap2 netns ns2
ip link set tap3 netns ns3
ip link set tap4 netns ns4
ip link set tap5 netns ns5

# bring up interfaces
nsenter --net=/run/netns/ns1 ip link set dev tap1 up
nsenter --net=/run/netns/ns2 ip link set dev tap2 up
nsenter --net=/run/netns/ns3 ip link set dev tap3 up
nsenter --net=/run/netns/ns4 ip link set dev tap4 up
nsenter --net=/run/netns/ns5 ip link set dev tap5 up

# assign IP addresses to interfaces
ip1="192.168.2.1"
ip2="192.168.2.2"
ip3="192.168.2.3"
ip4="192.168.2.4"
ip5="192.168.2.5"

nsenter --net=/run/netns/ns1 ip addr add "$ip1"/24 dev tap1
nsenter --net=/run/netns/ns2 ip addr add "$ip2"/24 dev tap2
nsenter --net=/run/netns/ns3 ip addr add "$ip3"/24 dev tap3
nsenter --net=/run/netns/ns4 ip addr add "$ip4"/24 dev tap4
nsenter --net=/run/netns/ns5 ip addr add "$ip5"/24 dev tap5

# setup OpenSSH

known_hosts="/root/.ssh/known_hosts"
authorized_keys="/root/.ssh/authorized_keys"

mkdir -p /root/.ssh
touch "$known_hosts"
touch "$authorized_keys"
chmod 700 /root/.ssh
chmod 600 /root/.ssh/known_hosts

key1="/root/.ssh/key1"
key2="/root/.ssh/key2"
key3="/root/.ssh/key3"
key4="/root/.ssh/key4"
key5="/root/.ssh/key5"

ssh-keygen -t ed25519 -C "$ip1" -f "$key1" -N ""
ssh-keygen -t ed25519 -C "$ip2" -f "$key2" -N ""
ssh-keygen -t ed25519 -C "$ip3" -f "$key3" -N ""
ssh-keygen -t ed25519 -C "$ip4" -f "$key4" -N ""
ssh-keygen -t ed25519 -C "$ip5" -f "$key5" -N ""

touch ~/.ssh/config
chmod 600 ~/.ssh/config

cat << EOF > ~/.ssh/config
Host host1 $ip1
    HostName $ip1
    IdentityFile $key1

Host host2 $ip2
    HostName $ip2
    IdentityFile $key2

Host host3 $ip3
    HostName $ip3
    IdentityFile $key3

Host host4 $ip4
    HostName $ip4
    IdentityFile $key4

Host host5 $ip5
    HostName $ip5
    IdentityFile $key5

EOF

pub1=$(<"$key1.pub")
pub2=$(<"$key2.pub")
pub3=$(<"$key3.pub")
pub4=$(<"$key4.pub")
pub5=$(<"$key5.pub")

echo "$pub1" >> "$authorized_keys"
echo "$pub2" >> "$authorized_keys"
echo "$pub3" >> "$authorized_keys"
echo "$pub4" >> "$authorized_keys"
echo "$pub5" >> "$authorized_keys"

echo "$ip1 $pub1" >> "$known_hosts"
echo "$ip2 $pub2" >> "$known_hosts"
echo "$ip3 $pub3" >> "$known_hosts"
echo "$ip4 $pub4" >> "$known_hosts"
echo "$ip5 $pub5" >> "$known_hosts"

cat << EOF > /etc/ssh/sshd_config.d/host1.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $key1
ListenAddress $ip1
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/host2.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $key2
ListenAddress $ip2
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/host3.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $key3
ListenAddress $ip3
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/host4.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $key4
ListenAddress $ip4
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/host5.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $key5
ListenAddress $ip5
PasswordAuthentication no
PermitRootLogin yes
EOF

service ssh stop

rm /etc/ssh/ssh_config 2> /dev/null || true

mkdir -p /run/sshd
chmod 755 /run/sshd
chown root:sys /run/sshd
