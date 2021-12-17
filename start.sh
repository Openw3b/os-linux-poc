../crosvm/target/debug/crosvm run -c 8 -m 4096 --disable-sandbox \
  --gpu backend=2d,height=1080,width=1920 \
  --host_ip=10.1.1.3 --netmask 255.255.255.0 --mac 70:5a:0f:2f:16:4e \
  --rwroot fs/fs.qcow2 \
  --display-window-keyboard \
  -p 'init=/init net.ifnames=0' \
  --socket vm.sock \
  --evdev /dev/input/event24 \
  --shared-dir shared:shared:type=fs \
  ../linux-5.15.8/arch/x86/boot/bzImage
