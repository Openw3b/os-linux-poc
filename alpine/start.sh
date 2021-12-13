sudo qemu-system-x86_64-spice  \
   -enable-kvm -cpu host -m 1024m -smp 4 \
   -kernel bzImage \
   -append "root=/dev/vda rw" \
   -drive id=root,file=alpine-large.qcow2,format=qcow2,if=none \
   -device virtio-blk-pci,drive=root \
   -nic user,model=virtio \
   -vga virtio \
#   -device virtio-tablet-pci,id=input2,bus=pci.0,addr=0x9 -spice port=0,disable-ticketing,image-compression=off,seamless-migration=on 
