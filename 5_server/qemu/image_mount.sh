echo_section "Example script to mount a disk image"

echo_subsection "Listing disk image disk information"
fdisk -l datadisk.raw

echo_info "When mounting the disk, the offset must match the starting sector."
echo "E.g. when the Start sector is listed as 2048,"
echo "the mount offset must be 2048 * 512 = 1048576"

echo_subsection "Mounting disk image"
ensure_dir tmp -sudo
sudo mount -t ext4 -o rw,loop,offset=1048576 datadisk.raw tmp/
