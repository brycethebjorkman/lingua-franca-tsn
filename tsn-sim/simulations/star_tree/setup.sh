#!/bin/bash
#
# configure network and SSH

num_hosts=120

# create interfaces
ip tuntap add mode tap dev tap_l
num=1
while [ $num -le $num_hosts ]
do
    ip tuntap add mode tap dev "tap$num"
    ((num++))
done

# create network namespaces
num=1
while [ $num -le $num_hosts ]
do
    ip netns add "ns$num"
    ((num++))
done

# move interfaces to network namespaces
num=1
while [ $num -le $num_hosts ]
do
    ip link set "tap$num" netns "ns$num"
    ((num++))
done

# bring up interfaces
ip link set dev tap_l up
num=1
while [ $num -le $num_hosts ]
do
    nsenter --net="/run/netns/ns$num" ip link set dev "tap$num" up
    ((num++))
done

# assign IP addresses to interfaces
ip_prefix="192.168.2."
l_ip="${ip_prefix}254"
ip addr add "$l_ip"/24 dev tap_l
num=1
while [ $num -le $num_hosts ]
do
    nsenter --net="/run/netns/ns$num" ip addr add "${ip_prefix}$num"/24 dev "tap$num"
    ((num++))
done

# setup OpenSSH

known_hosts="/root/.ssh/known_hosts"
authorized_keys="/root/.ssh/authorized_keys"

mkdir -p /root/.ssh
touch "$known_hosts"
touch "$authorized_keys"
chmod 700 /root/.ssh
chmod 600 /root/.ssh/known_hosts

## generate key pairs
l_key="/root/.ssh/localhost_key"
ssh-keygen -t ed25519 -C "$l_ip" -f "$l_key" -N ""
key_prefix="/root/.ssh/key"
num=1
while [ $num -le $num_hosts ]
do
    ssh-keygen -t ed25519 -C "${ip_prefix}$num" -f "${key_prefix}$num" -N ""
    ((num++))
done

## create client configs
touch ~/.ssh/config
chmod 600 ~/.ssh/config
ssh_config="
Host localhost $l_ip
    HostName $l_ip
    IdentityFile $l_key
"

num=1
while [ $num -le $num_hosts ]
do
    ssh_config+="
Host host$num ${ip_prefix}$num
    HostName ${ip_prefix}$num
    IdentityFile ${key_prefix}$num
"
    ((num++))
done
echo "$ssh_config" > ~/.ssh/config

## configure known_hosts for clients and authorized_keys for servers
l_pub=$(<"$l_key.pub")
echo "$l_pub" >> "$authorized_keys"
echo "$l_ip $l_pub" >> "$known_hosts"
num=1
while [ $num -le $num_hosts ]
do
    pub=$(<"${key_prefix}$num.pub")
    echo "$pub" >> "$authorized_keys"
    echo "${ip_prefix}$num $pub" >> "$known_hosts"
    ((num++))
done

## configure servers
cat << EOF > /etc/ssh/sshd_config.d/localhost.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey $l_key
ListenAddress $l_ip
PasswordAuthentication no
PermitRootLogin yes
EOF
num=1
while [ $num -le $num_hosts ]
do
    cat <<-EOF > /etc/ssh/sshd_config.d/host$num.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey ${key_prefix}$num
ListenAddress ${ip_prefix}$num
PasswordAuthentication no
PermitRootLogin yes
EOF
    ((num++))
done

service ssh stop

rm /etc/ssh/ssh_config 2> /dev/null || true

mkdir -p /run/sshd
chmod 755 /run/sshd
chown root:sys /run/sshd
