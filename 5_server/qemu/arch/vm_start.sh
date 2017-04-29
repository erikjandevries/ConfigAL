echo_section "Starting Virtual Machine"

qemu-system-x86_64 -enable-kvm      \
  -name ArchLinux                   \
  -cpu host                         \
  -smp cores=2,threads=1,sockets=1  \
  -m 4G                             \
  -boot order=c                     \
  -hda archlinux.raw                \
  -hdb datadisk.raw                 \
  -netdev user,id=vmnic -device virtio-net,netdev=vmnic \
&



# qemu-system-x86_64
#   -M pc
#   -cpu host
#   -smp cores=2,threads=1,sockets=1
#   -drive file=/dev/sda6,if=virtio,cache=none,index=0
#   -drive file=/dev/sdb,if=virtio,cache=none,index=1
#   -cdrom /dev/cdrom
#   -pidfile ./qemu-garak.pid
#   -boot c
#   -k de
#   -m 4096
#   -device pci-assign,host=01:05.0
#   -daemonize -usb
#   -usbdevice "tablet"
#   -name garak
#   -net nic,vlan=0,model=virtio,macaddr=02:01:01:01:01:01
#   -net tap,vlan=0,ifname=virtnet1,script=/etc/qemu-ifup,downscript=/etc/qemu-ifup
#   -vnc :1
