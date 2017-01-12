#### Load settings for part 2 ####
source /root/install_os_part_2_settings.sh
source /root/ConfigAL_functions.sh



echo_subsection "Checking for Virtual Machine"
# See http://unix.stackexchange.com/questions/89714/easy-way-to-determine-virtualization-technology
pacman -S --noconfirm --color auto dmidecode
# VM_HOST=$(dmidecode -s system-manufacturer)
VM_HOST=$(dmidecode -s system-product-name)
if [[ "$VM_HOST" == "VirtualBox" ]]; then
  echo_info "VirtualBox found... installing guest additions"
  pacman -S --noconfirm --color auto virtualbox-guest-modules-arch
  pacman -S --noconfirm --color auto virtualbox-guest-utils
  systemctl enable vboxservice
fi



echo_subsection "Hostname"
touch /etc/hostname
if [[ "x$OS_HOSTNAME" == "x" ]]; then
  echo_warn "Hostname not set"
else
  echo_info "$OS_HOSTNAME"
  echo "$OS_HOSTNAME" > /etc/hostname
fi



echo_subsection "Time Zone"
echo_info "$OS_TIME_ZONE"
ln -s /usr/share/zoneinfo/$OS_TIME_ZONE /etc/localtime
hwclock --systohc



echo_subsection "Locale"
replace_conf "#en_GB.UTF-8 UTF-8" "en_GB.UTF-8 UTF-8" /etc/locale.gen
replace_conf "#en_US.UTF-8 UTF-8" "en_US.UTF-8 UTF-8" /etc/locale.gen
replace_conf "#nl_NL.UTF-8 UTF-8" "nl_NL.UTF-8 UTF-8" /etc/locale.gen
replace_conf "#nl_NL@euro ISO-8859-15" "nl_NL@euro ISO-8859-15" /etc/locale.gen
locale-gen
echo_info "$OS_LOCALE"
echo LANG=$OS_LOCALE > /etc/locale.conf
export LANG=$OS_LOCALE



echo_subsection "Installing packages"
pacman -Syy
echo_info "Installing bash-completion"
pacman -S --noconfirm --color auto bash-completion

echo_info "Installing sudo"
pacman -S --noconfirm --color auto sudo
groupadd sudo
replace_conf "# %sudo\tALL=(ALL) ALL" "%sudo\tALL=(ALL) ALL" /etc/sudoers


echo_subsection "Configuring users"
if [[ "x$OS_ROOT_PASSWD" == "x" ]]; then
  echo_warn "Root password not set"
else
  echo_info "Setting root password"
  echo "root:$OS_ROOT_PASSWD" | chpasswd
fi

#### Create a user account ####
if [[ "x$OS_NEW_USERNAME" == "x" ]]; then
  echo_warn "New username not set"
else
  if [[ "$OS_NEW_USERNAME_SUDO" == "true" ]]; then
    useradd -m -g users -G wheel,storage,power,sudo -s /bin/bash $OS_NEW_USERNAME
  else
    useradd -m -g users -G wheel,storage,power -s /bin/bash $OS_NEW_USERNAME
  fi
  if [[ "x$OS_NEW_USERNAME_PASSWD" == "x" ]]; then
    echo_warn "Password for user $OS_NEW_USERNAME not set"
  else
    echo_info "Setting password for user $OS_NEW_USERNAME"
    echo "$OS_NEW_USERNAME:$OS_NEW_USERNAME_PASSWD" | chpasswd
  fi
fi



echo_subsection "Installing boot loader"
if [[ "$EFI_BOOT" == "true" ]]; then
  echo_info "Installing EFI boot loader"

  bootctl --path=/boot install

  BOOTLOADER_CONF=/boot/loader/loader.conf
  rm $BOOTLOADER_CONF
  echo "default  arch" >> $BOOTLOADER_CONF
  echo "timeout  3" >> $BOOTLOADER_CONF
  echo "editor   0" >> $BOOTLOADER_CONF

  BOOTLOADER_ARCH_CONF=/boot/loader/entries/arch.conf
  echo "title    Arch Linux" >> $BOOTLOADER_ARCH_CONF
  echo "linux    /vmlinuz-linux" >> $BOOTLOADER_ARCH_CONF
  # echo "initrd   /intel-ucode.img # only if you have an Intel processor" >> $BOOTLOADER_ARCH_CONF
  echo "initrd   /initramfs-linux.img" >> $BOOTLOADER_ARCH_CONF
  PARTUUID=$(blkid -o export $OS_PARTITION | grep PARTUUID | awk -F'[=&]' '{print $2}')
  echo "options  root=PARTUUID=$PARTUUID rw" >> $BOOTLOADER_ARCH_CONF
else
  echo_info "Installing GRUB boot loader"

  pacman -S --noconfirm --color auto grub
  grub-install --target=i386-pc --recheck $OS_DISK
  grub-mkconfig -o /boot/grub/grub.cfg
fi



echo_subsection "Enabling network connection"
NIC_NAME=$(ip link | grep -m 1 "BROADCAST" | awk -F': ' '{print $2}')
systemctl enable dhcpcd@${NIC_NAME}.service
# systemctl enable NetworkManager
