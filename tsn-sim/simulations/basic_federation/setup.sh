# create TAP interfaces
ip tuntap add mode tap dev tap_l
ip tuntap add mode tap dev tap_r
ip tuntap add mode tap dev tap_c
ip tuntap add mode tap dev tap_p

# create network namespace
ip netns add ns_r
ip netns add ns_c
ip netns add ns_p

# move tap to network namespace
ip link set tap_r netns ns_r
ip link set tap_c netns ns_c
ip link set tap_p netns ns_p

# bring up all interfaces
ip link set dev tap_l up
nsenter --net=/run/netns/ns_r ip link set dev tap_r up
nsenter --net=/run/netns/ns_c ip link set dev tap_c up
nsenter --net=/run/netns/ns_p ip link set dev tap_p up

# assign IP addresses to interfaces
l_ip="192.168.2.1"
r_ip="192.168.2.2"
c_ip="192.168.2.3"
p_ip="192.168.2.4"

ip addr add "$l_ip"/24 dev tap_l
nsenter --net=/run/netns/ns_r ip addr add "$r_ip"/24 dev tap_r
nsenter --net=/run/netns/ns_c ip addr add "$c_ip"/24 dev tap_c
nsenter --net=/run/netns/ns_p ip addr add "$p_ip"/24 dev tap_p

# setup OpenSSH

known_hosts="/root/.ssh/known_hosts"
authorized_keys="/root/.ssh/authorized_keys"

mkdir -p /root/.ssh
touch "$known_hosts"
touch "$authorized_keys"
chmod 700 /root/.ssh
chmod 600 /root/.ssh/known_hosts

l_key="/root/.ssh/localhost_key"
r_key="/root/.ssh/rti_key"
c_key="/root/.ssh/federate_c_key"
p_key="/root/.ssh/federate_p_key"

ssh-keygen -t ed25519 -C "$l_ip" -f "$l_key" -N ""
ssh-keygen -t ed25519 -C "$r_ip" -f "$r_key" -N ""
ssh-keygen -t ed25519 -C "$c_ip" -f "$c_key" -N ""
ssh-keygen -t ed25519 -C "$p_ip" -f "$p_key" -N ""

touch ~/.ssh/config
chmod 600 ~/.ssh/config

cat << EOF > ~/.ssh/config
Host localhost $l_ip
    HostName $l_ip
    IdentityFile $l_key

Host rti $r_ip
    HostName $r_ip
    IdentityFile $r_key

Host federate_c $c_ip
    HostName $c_ip
    IdentityFile $c_key

Host federate_p $p_ip
    HostName $p_ip
    IdentityFile $p_key
EOF

l_pub=$(<"$l_key.pub")
r_pub=$(<"$r_key.pub")
c_pub=$(<"$c_key.pub")
p_pub=$(<"$p_key.pub")

echo "$l_pub" >> "$authorized_keys"
echo "$r_pub" >> "$authorized_keys"
echo "$c_pub" >> "$authorized_keys"
echo "$p_pub" >> "$authorized_keys"

echo "$l_ip $l_pub" >> "$known_hosts"
echo "$r_ip $r_pub" >> "$known_hosts"
echo "$c_ip $c_pub" >> "$known_hosts"
echo "$p_ip $p_pub" >> "$known_hosts"

cat << EOF > /etc/ssh/sshd_config.d/localhost.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/localhost_key
ListenAddress $l_ip
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/rti.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/rti_key
ListenAddress $r_ip
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/federate_c.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/federate_c_key
ListenAddress $c_ip
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/federate_p.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/federate_p_key
ListenAddress $p_ip
PasswordAuthentication no
PermitRootLogin yes
EOF

service ssh stop

rm /etc/ssh/ssh_config 2> /dev/null || true

mkdir -p /run/sshd
chmod 755 /run/sshd
chown root:sys /run/sshd
