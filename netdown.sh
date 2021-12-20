# Disable NAT
sudo /sbin/iptables -D FORWARD -i enp2s0 -o tap_netvm1_in -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo /sbin/iptables -D FORWARD -o enp2s0 -i tap_netvm1_in -j ACCEPT

# Delete a briddge after removing interfaces
sudo brctl delif br_appvm1_netvm1 tap_appvm1_in
sudo brctl delif br_appvm1_netvm1 tap_netvm1_out
sudo ifconfig br_appvm1_netvm1 down 
sudo brctl delbr br_appvm1_netvm1

# Delete TAP interfaces
sudo tunctl -d tap_netvm1_in
sudo tunctl -d tap_netvm1_out
sudo tunctl -d tap_appvm1_in