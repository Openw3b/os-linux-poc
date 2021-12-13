#!/bin/bash

set -e 

APP_NAME="firefox-ubuntu"

#gcc -Wall -o init -static init.c
if [ -d /mnt/ramdisk ]; then
    echo "Unmounting RamDisk"
    sudo umount /mnt/ramdisk || true
fi
echo "Mounting RamDisk"
sudo mount -t tmpfs -o size=3G tmpfs /mnt/ramdisk
DOCKER_BUILDKIT=1 docker build --output "type=tar,dest=/mnt/ramdisk/fs.tar" -f ./Dockerfile-${APP_NAME}  --no-cache .
echo "Docker build finished"
echo "Running virt-make-fs"
sudo virt-make-fs --format=qcow2 --size=+2G /mnt/ramdisk/fs.tar ./fs/${APP_NAME}.qcow2
echo "Virt-make-fs finished"
sudo chown akram:akram ./fs/${APP_NAME}.qcow2
#sudo rm alpine.tar
#qemu-img convert alpine-large.qcow2 -O qcow2 alpine.qcow2
#cp alpine-large.qcow2 ../os/alpine.qcow2
