#!/bin/bash

../crosvm/target/debug/crosvm run -c 4 -m 4096 --disable-sandbox \
    --host_ip=10.1.1.1 --netmask 255.255.255.0 --mac 70:5a:0f:2f:16:4e \
    --rwdisk ./fs/firefox.qcow2 \
    -p 'init=/init root=/dev/vda rw' \
    --wayland-sock /run/user/1000/wayland-0 \
    ../chromeos-kernel/vmlinux