# create TAP interfaces
ip tuntap add mode tap dev tap_rti
ip tuntap add mode tap dev tap_c
ip tuntap add mode tap dev tap_p

# assign IP addresses to interfaces
ip addr add 192.168.2.20/24 dev tap_rti
ip addr add 192.168.3.20/24 dev tap_c
ip addr add 192.168.4.20/24 dev tap_p

# bring up all interfaces
ip link set dev tap_rti up
ip link set dev tap_c up
ip link set dev tap_p up

# setup OpenSSH
mkdir -p /root/.ssh
touch /root/.ssh/known_hosts
touch /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/known_hosts

ssh-keygen -t ed25519 -C "127.0.0.1" -f ~/.ssh/localhost_key -N ""
ssh-keygen -t ed25519 -C "192.168.2.20" -f ~/.ssh/rti_key -N ""
ssh-keygen -t ed25519 -C "192.168.3.20" -f ~/.ssh/federate_c_key -N ""
ssh-keygen -t ed25519 -C "192.168.4.20" -f ~/.ssh/federate_p_key -N ""

touch ~/.ssh/config
chmod 600 ~/.ssh/config

cat << EOF > ~/.ssh/config
Host localhost 127.0.0.1
    HostName 127.0.0.1
    IdentityFile ~/.ssh/localhost_key

Host rti 192.168.2.20
    HostName 192.168.2.20
    IdentityFile ~/.ssh/rti_key

Host federate_c 192.168.3.20
    HostName 192.168.3.20
    IdentityFile ~/.ssh/federate_c_key

Host federate_p 192.168.4.20
    HostName 192.168.4.20
    IdentityFile ~/.ssh/federate_p_key
EOF

cat /root/.ssh/localhost_key.pub >> /root/.ssh/authorized_keys
cat /root/.ssh/rti_key.pub >> /root/.ssh/authorized_keys
cat /root/.ssh/federate_c_key.pub >> /root/.ssh/authorized_keys
cat /root/.ssh/federate_p_key.pub >> /root/.ssh/authorized_keys

cat << EOF > /etc/ssh/sshd_config.d/localhost.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/localhost_key
ListenAddress 192.168.2.20
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/rti.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/rti_key
ListenAddress 192.168.2.20
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/federate_c.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/federate_c_key
ListenAddress 192.168.3.20
PasswordAuthentication no
PermitRootLogin yes
EOF

cat << EOF > /etc/ssh/sshd_config.d/federate_p.conf
AllowTcpForwarding yes
GatewayPorts yes
HostKey /root/.ssh/federate_p_key
ListenAddress 192.168.4.20
PasswordAuthentication no
PermitRootLogin yes
EOF

service ssh stop

mkdir -p /run/sshd
chmod 755 /run/sshd
chown root:sys /run/sshd

/usr/sbin/sshd -f /etc/ssh/sshd_config.d/localhost.conf
/usr/sbin/sshd -f /etc/ssh/sshd_config.d/rti.conf
/usr/sbin/sshd -f /etc/ssh/sshd_config.d/federate_c.conf
/usr/sbin/sshd -f /etc/ssh/sshd_config.d/federate_p.conf

ssh-keyscan -t ed25519 -H 127.0.0.1 >> ~/.ssh/known_hosts
ssh-keyscan -t ed25519 -H 192.168.2.20 >> ~/.ssh/known_hosts
ssh-keyscan -t ed25519 -H 192.168.3.20 >> ~/.ssh/known_hosts
ssh-keyscan -t ed25519 -H 192.168.4.20 >> ~/.ssh/known_hosts

