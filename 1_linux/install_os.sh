echo_section "Installing Arch Linux"

mount $OS_PARTITION /mnt
mkdir /mnt/boot
mount $BOOT_PARTITION /mnt/boot

echo_info "Using mirrorlist for: $MIRRORLIST_COUNTRY"
cp $CONFIGAL_REPO/1_linux/config_files/mirrorlist_$MIRRORLIST_COUNTRY /etc/pacman.d/mirrorlist

echo_info "Installing Arch Linux"
pacstrap /mnt base base-devel

echo_info "Generating /etc/fstab"
genfstab -U /mnt >> /mnt/etc/fstab

cp $CONFIGAL_REPO/1_linux/install_os_part_2.sh /mnt/root/
tee /mnt/root/install_os_part_2_settings.sh << EOF > /dev/null
TIME_ZONE=$TIME_ZONE
HOSTNAME=$HOSTNAME
USERNAME=$USERNAME
OS_DISK=$OS_DISK
EFI_BOOT=$EFI_BOOT
EOF
chmod 700 /mnt/root/install_os_part_2.sh
chmod 700 /mnt/root/install_os_part_2_settings.sh

arch-chroot /mnt /root/install_os_part_2.sh

rm /mnt/root/install_os_part_2.sh
rm /mnt/root/install_os_part_2_settings.sh
umount -R /mnt

reboot
