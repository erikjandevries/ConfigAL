echo_section "Installing Virtual Machine"

qemu-system-x86_64 -enable-kvm      \
  -name ArchLinux                   \
  -cpu host                         \
  -smp cores=2,threads=1,sockets=1  \
  -m 4G                             \
  -boot order=d                     \
  -hda archlinux.raw                \
  -hdb datadisk.raw                 \
  -cdrom ~/Software/Linux\ Mint/linuxmint-18.1-cinnamon-64bit.iso \
  -netdev user,id=vmnic -device virtio-net,netdev=vmnic \
  -writeconfig "vm_config.cfg"      \
&
