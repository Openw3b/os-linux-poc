# Enable IPv4 forwarding
sudo sysctl net.ipv4.ip_forward=1

USERNAME=neo
WAN=enp2s0

# Create TAP interfaces
sudo tunctl -t tap_netvm1_in -u $USERNAME
sudo tunctl -t tap_netvm1_out -u $USERNAME
sudo tunctl -t tap_appvm1_in -u $USERNAME
sudo ifconfig tap_netvm1_in up
sudo ifconfig tap_netvm1_out up
sudo ifconfig tap_appvm1_in up

# Configure TAP Interfaces
sudo ifconfig tap_netvm1_in up 10.99.0.1/24

# Enable NAT
sudo iptables -t nat  -A POSTROUTING -o $WAN -j MASQUERADE
sudo /sbin/iptables -A FORWARD -i $WAN -o tap_netvm1_in -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -A FORWARD -o $WAN -i tap_netvm1_in -j ACCEPT

# Create a briddge and add vm interfaces to it
sudo brctl addbr br_appvm1_netvm1
sudo ifconfig br_appvm1_netvm1 up
sudo brctl addif br_appvm1_netvm1 tap_netvm1_out
sudo brctl addif br_appvm1_netvm1 tap_appvm1_in
