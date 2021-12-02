#!/bin/bash

# Do not run this file directly
exit 


# Run this inside guest vm
sudo ip addr flush dev enp0s4
sudo ip addr add dev enp0s4 10.1.1.2/24
sudo ip link set up dev enp0s4
sudo ip route add default via 10.1.1.1 dev enp0s4

su root -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf'

## Run this on the host

sudo sysctl net.ipv4.ip_forward=1
sudo iptables -t nat  -A POSTROUTING -o enp1s0 -j MASQUERADE
sudo /sbin/iptables -A FORWARD -i enp1s0 -o vmtap0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -A FORWARD -o enp1s0 -i vmtap0 -j ACCEPT


## Installing sommelier
sudo apt install -y git meson build-essential 
git clone https://chromium.googlesource.com/chromiumos/platform2
cd platform2/vm_tools/sommelier

sudo apt install -y libwayland-dev cmake pkg-config libgbm-dev libdrm-dev libpixman-1-dev libx11-xcb-dev libxcb-composite0-dev libxkbcommon-dev libgtest-dev
meson build
sudo ninja -C build install



# run wayland
sudo chown user:user /dev/wl0
export XDG_RUNTIME_DIR=/tmp/wayland
mkdir -p $XDG_RUNTIME_DIR
export MOZ_ENABLE_WAYLAND=1

sudo mkdir -p /opt/google/cros-containers/bin/
sudo ln -s /usr/bin/Xwayland /opt/google/cros-containers/bin/Xwayland
sommelier firefox