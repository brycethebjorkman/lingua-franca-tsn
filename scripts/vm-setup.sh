#!/bin/bash
#
# sets up a QEMU VM with a TAP interface in a network namespace

# create tap interface
ip tuntap add mode tap dev tap1

# create bridge
ip link add br1 type bridge

# clear host interface ip
ip addr flush dev tap0

# add interfaces to bridge
ip link set dev tap0 master br1
ip link set dev tap1 master br1

# bring up all interfaces
ip link set dev tap0 up
ip link set dev tap1 up
ip link set dev br1 up

# assign ip address to bridge
dhclient -v br1

cat > metadata.yaml <<EOF
instance-id: iid-vm1
local-hostname: vm1
EOF

ssh-keygen -t ed25519 -f vm1_key -N ""
vm1_pub=$(<"vm1_key.pub")

cat > user-data.yaml <<EOF
#cloud-config
password: root
chpasswd: { expire: False }
ssh_authorized_keys:
  - $vm1_pub
EOF

cloud-localds seed.img user-data.yaml metadata.yaml

VM_QCOW2="jammy-server-cloudimg-amd64-disk-kvm.img"

#nsenter --net=/run/netns/ns1 \
qemu-system-x86_64 \
    -name "VM" \
    -enable-kvm \
    -machine type=q35,accel=kvm \
    -cpu host \
    -smp cores=4,threads=1,sockets=1 \
    -m 8G \
    -drive "file=${VM_QCOW2},if=virtio,format=qcow2" \
    -drive if=virtio,format=raw,file=seed.img \
    -rtc clock=vm,base=localtime \
    -netdev tap,id=net0,ifname=tap1,script=no,downscript=no \
    -device virtio-net-pci,netdev=net0,mac=42:aa:00:60:00:01 \
    -nographic \
    && true

    #-netdev tap,id=net1,ifname=tap1,script=no,downscript=no \
    #-netdev user,id=net0,hostfwd=tcp::2222-:22 \
    #-device virtio-net-pci,netdev=net0 \
    #-device virtio-net-pci,netdev=net1,mac=42:aa:00:60:00:01 \

exit 0

ssh -o "StrictHostKeyChecking no" -p 2222 -i vm1_key ubuntu@0.0.0.0

nsenter --net=/run/netns/ns1 \
ssh -o "StrictHostKeyChecking no" -i vm1_key ubuntu@192.168.2.1

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    linuxptp \
    && apt-get clean
