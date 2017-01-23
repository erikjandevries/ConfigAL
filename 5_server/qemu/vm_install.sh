echo_section "Installing Virtual Machine"

qemu-system-x86_64 -enable-kvm \
  -name ArchLinux              \
  -m 4G                        \
  -boot order=d                \
  -hda archlinux.raw           \
  -hdb datadisk.raw            \
  -cdrom ~/Software/Arch\ Linux/archlinux-2017.01.01-dual.iso \
  -writeconfig "vm_config.cfg" \
&
