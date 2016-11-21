#### 1 Linux ####

# Prepare Data disk
PREPARE_DATA_DISK=false
DATA_DISK=/dev/sdb
DATA_PARTITION=${DATA_DISK}1
DATA_PARTITION_FS=ext4  # ext4

# Prepare OS disk
PREPARE_OS_DISK=true
EFI_BOOT=false
OS_DISK=/dev/sda
BOOT_PARTITION=${OS_DISK}1
BOOT_PARTITION_FS=fat32  # fat32
OS_PARTITION=${OS_DISK}2
OS_PARTITION_FS=btrfs  # ext4, btrfs

# Install OS
MIRRORLIST_COUNTRY=NL
TIME_ZONE=Europe/Amsterdam

source $CONFIGAL_REPO/9_private_config/ConfigAL_private_settings.sh