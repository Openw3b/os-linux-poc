#!/bin/sh

ip addr add dev enp0s4 10.1.1.2/24
ip link set up dev enp0s4
ip route add default via 10.1.1.1 dev enp0s4
echo "nameserver 1.1.1.1" > /etc/resolv.conf

chown user:user /dev/wl0

# sudo -H -u user bash -c 'export XDG_RUNTIME_DIR=/run/user/1000 && sommelier -X firefox' 

# Uncomment below line to stop VM on application exit
# shutdown -h now