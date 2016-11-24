echo_section "Installing Arch Linux"

mount $OS_PARTITION /mnt
mkdir /mnt/boot
mount $BOOT_PARTITION /mnt/boot

echo_info "Using mirrorlist for: $MIRRORLIST_COUNTRY"
cp $CONFIGAL_REPO/1_linux/install_os/config_files/mirrorlist_$MIRRORLIST_COUNTRY /etc/pacman.d/mirrorlist

if [[ "$DEVEL_PACKAGES" == "true" ]]; then
  echo_info "Installing Arch Linux with development packages"
  pacstrap /mnt base base-devel
else
  echo_info "Installing Arch Linux"
  pacstrap /mnt base
fi

echo_info "Generating /etc/fstab"
genfstab -U /mnt >> /mnt/etc/fstab

mkdir $DATA_PARTITION_MOUNT_FOLDER
ensure_conf "$DATA_PARTITION $DATA_PARTITION_MOUNT_FOLDER ext4 errors=remount-ro 0 0" /mnt/etc/fstab -sudo

cp $CONFIGAL_REPO/1_linux/install_os/install_os_part_2.sh /mnt/root/
cp $CONFIGAL_REPO/ConfigAL_functions.sh /mnt/root/
tee /mnt/root/install_os_part_2_settings.sh << EOF > /dev/null
OS_TIME_ZONE=$OS_TIME_ZONE
OS_LOCALE=$OS_LOCALE
OS_HOSTNAME=$OS_HOSTNAME
OS_ROOT_PASSWD=$OS_ROOT_PASSWD
OS_NEW_USERNAME=$OS_NEW_USERNAME
OS_NEW_USERNAME_PASSWD=$OS_NEW_USERNAME_PASSWD
OS_NEW_USERNAME_SUDO=$OS_NEW_USERNAME_SUDO
OS_DISK=$OS_DISK
EFI_BOOT=$EFI_BOOT
EOF
chmod 700 /mnt/root/install_os_part_2.sh
chmod 700 /mnt/root/install_os_part_2_settings.sh
chmod 700 /mnt/root/ConfigAL_functions.sh

arch-chroot /mnt /root/install_os_part_2.sh

rm /mnt/root/install_os_part_2.sh
rm /mnt/root/install_os_part_2_settings.sh
rm /mnt/root/ConfigAL_functions.sh

umount -R /mnt

reboot
