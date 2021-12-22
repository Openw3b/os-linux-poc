../crosvm/target/debug/crosvm run -c 8 -m 4096 --disable-sandbox \
  --gpu backend=2d,height=1080,width=1920 \
  --tap-name tap_appvm1_in \
  --rwroot fs/fs.qcow2 \
  --display-window-keyboard \
  -p 'init=/init net.ifnames=0 ip=10.99.1.2::10.99.1.1:255.255.255.0::eth0:off' \
  --socket vm.sock \
  --vhost-net \
  bzImage

#  --shared-dir shared:shared:type=fs \