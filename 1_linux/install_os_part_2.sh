#### Load settings for part 2 ####
source /root/install_os_part_2_settings.sh
source /root/ConfigAL_functions.sh

#### Time Zone ####
ln -s /usr/share/zoneinfo/$TIME_ZONE /etc/localtime
hwclock --systohc

#### Locale ####


#### Hostname ####
touch /etc/hostname
if [[ "x$HOSTNAME" == "x" ]]; then
  echo_warn "Hostname not set"
else
  echo "$HOSTNAME" >> /etc/hostname
fi

#### Set root password ####
echo_warn "Setting Root password"
passwd
#### Create a user account ####
if [[ "x$NEW_USERNAME" == "x" ]]; then
  echo_warn "Username not set"
else
  echo_warn "Setting password for user $NEW_USERNAME"
  useradd -m -g users -G wheel,storage,power -s /bin/bash $NEW_USERNAME
  passwd $NEW_USERNAME
fi

#### Install boot loader ####

if [[ "$EFI_BOOT" == "true" ]]; then
  echo_warn "EFI boot is currently not supported!"

# bootctl --path=/boot install
#
# BOOTLOADER_CONF=/boot/loader/loader.conf
# rm $BOOTLOADER_CONF
# echo "default  arch" >> $BOOTLOADER_CONF
# echo "timeout  3" >> $BOOTLOADER_CONF
# echo "editor   0" >> $BOOTLOADER_CONF
#
# BOOTLOADER_ARCH_CONF=/boot/loader/entries/arch.conf
# echo "title    Arch Linux" >> $BOOTLOADER_ARCH_CONF
# echo "linux    /vmlinuz-linux" >> $BOOTLOADER_ARCH_CONF
# # echo "initrd   /intel-ucode.img # only if you have an Intel processor" >> $BOOTLOADER_ARCH_CONF
# echo "initrd   /initramfs-linux.img" >> $BOOTLOADER_ARCH_CONF
# PARTUUID=$(blkid -o export /dev/sda2 | grep PARTUUID | awk -F'[=&]' '{print $2}')
# echo "options  root=PARTUUID=$PARTUUID rw" >> $BOOTLOADER_ARCH_CONF

else
  echo_info "Installing GRUB boot loader"

  pacman -S grub
  grub-install --target=i386-pc --recheck $OS_DISK
  grub-mkconfig -o /boot/grub/grub.cfg
fi

#### Enable internet ####
NIC_NAME=$(ip link | grep -m 1 "BROADCAST" | awk -F': ' '{print $2}')
systemctl enable dhcpcd@${NIC_NAME}.service

#### Exit ####
exit
