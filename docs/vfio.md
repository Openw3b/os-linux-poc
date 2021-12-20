  --vfio /sys/bus/pci/devices/0000\:03\:00.0 \

  driverctl unset-override 02:00.0
  driverctl set-override 02:00.0 vfio-pci