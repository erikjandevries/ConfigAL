echo_section "Starting Virtual Machine"

qemu-system-x86_64 -enable-kvm \
  -name ArchLinux              \
  -m 4G                        \
  -boot order=c                \
  -hda archlinux.raw           \
  -hdb datadisk.raw            \
&
