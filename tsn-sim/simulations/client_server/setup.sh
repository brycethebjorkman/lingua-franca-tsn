# create TAP interfaces
ip tuntap add mode tap dev tapa
ip tuntap add mode tap dev tapb

# assign IP addresses to interfaces
ip addr add 192.168.2.20/24 dev tapa
ip addr add 192.168.3.20/24 dev tapb

# bring up all interfaces
ip link set dev tapa up
ip link set dev tapb up
