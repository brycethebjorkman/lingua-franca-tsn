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
