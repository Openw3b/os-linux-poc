../crosvm/target/debug/crosvm run -c 8 -m 4096 --disable-sandbox \
  --gpu backend=2d \
  --host_ip=10.1.1.3 --netmask 255.255.255.0 --mac 70:5a:0f:2f:16:4e \
  --rwroot fs.qcow2 \
  --display-window-keyboard --display-window-mouse \
  -p 'init=/init' \
  --socket vm.sock \
  bzImage
