echo_section "Example script to create a disk image for use with QEMU"

echo_subsection "Creating a RAW disk image"
qemu-img create \
  -f raw \
  datadisk.raw \
  100G

qemu-img create \
  -f raw \
  linuxmint.raw \
  50G


echo_subsection "Creating a QCOW2 disk image"
qemu-img create \
  -o backing_file=backing_file.raw,backing_fmt=raw \
  -f qcow2 \
  image_file.cow \
  10G
