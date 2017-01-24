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
