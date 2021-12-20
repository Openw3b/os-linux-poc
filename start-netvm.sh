../crosvm/target/debug/crosvm run -c 2 -m 512 --disable-sandbox \
  --rwroot netvm/fs/fs.qcow2 \
  -p 'net.ifnames=0 init=/init -- 10.99.0.254 255.255.255.0 10.99.0.1 10.99.1.1 255.255.255.0' \
  --tap-name tap_netvm1_in \
  --tap-name tap_netvm1_out \
  --socket netvm.sock \
  ../linux-5.15.8/arch/x86/boot/bzImage