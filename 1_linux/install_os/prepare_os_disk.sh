# See:
# https://wiki.archlinux.org/index.php/installation_guide
# https://medium.com/@terusus/arch-linux-installation-copy-paste-guide-cdab7851e6d2

if [[ "$PREPARE_OS_DISK" == "true" ]]; then
  echo_section "Preparing OS disk"

  BOOT_PARTITION=${OS_DISK}1
  OS_PARTITION=${OS_DISK}2

  if [[ "$EFI_BOOT" == "true" ]]; then
    echo_info "Preparing disk for EFI boot"
    parted $OS_DISK mklabel gpt

    if [[ "$BOOT_PARTITION_FS" == "fat32" ]]; then
      parted $OS_DISK mkpart ESP fat32 1MiB 513MiB set 1 boot on
      mkfs.fat -F32 $BOOT_PARTITION
    fi
  else
    echo_info "Preparing disk for BIOS boot"
    parted $OS_DISK mklabel msdos

    if [[ "$BOOT_PARTITION_FS" == "fat32" ]]; then
      parted $OS_DISK mkpart primary fat32 1MiB 513MiB set 1 boot on
      mkfs.fat -F32 $BOOT_PARTITION
    fi
  fi

  if [[ "$OS_PARTITION_FS" == "btrfs" ]]; then
    parted $OS_DISK mkpart primary btrfs 513MiB 100%
    mkfs.btrfs -f -d single -m single $OS_PARTITION
  elif [[ "$OS_PARTITION_FS" == "ext4" ]]; then
    parted $OS_DISK mkpart primary ext4 513MiB 100%
    mkfs.ext4 $OS_PARTITION
  fi
fi

echo_info "Using OS disk:       $OS_DISK"
echo      "with boot partition: $BOOT_PARTITION"
echo      "and OS partition:    $OS_PARTITION"
