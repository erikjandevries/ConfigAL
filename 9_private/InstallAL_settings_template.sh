# Prepare Data disk
PREPARE_DATA_DISK=false
DATA_DISK=/dev/sdb
DATA_PARTITION=${DATA_DISK}1
DATA_PARTITION_FS=ext4  # ext4

# Prepare OS disk
PREPARE_OS_DISK=true
if [[ -d /sys/firmware/efi ]]; then
  EFI_BOOT=true
else
  EFI_BOOT=false
fi
OS_DISK=/dev/sda
BOOT_PARTITION=${OS_DISK}1
BOOT_PARTITION_FS=fat32  # fat32
OS_PARTITION=${OS_DISK}2
OS_PARTITION_FS=btrfs  # ext4, btrfs

# Install OS
MIRRORLIST_COUNTRY=NL
DEVEL_PACKAGES=true

OS_HOSTNAME="archlinux.local"
OS_NEW_USERNAME="myname"
OS_NEW_USERNAME_SUDO=true
DATA_PARTITION_MOUNT_FOLDER=/mnt/datadisk

# Install OS - part 2
OS_TIME_ZONE=Europe/Amsterdam
OS_LOCALE=en_GB.UTF-8
