# See:
# https://wiki.archlinux.org/index.php/installation_guide
# https://medium.com/@terusus/arch-linux-installation-copy-paste-guide-cdab7851e6d2

if [[ "$PREPARE_DATA_DISK" == "true" ]]; then
  echo_section "Preparing data disk"

  parted $DATA_DISK mklabel gpt

  DATA_PARTITION=${DATA_DISK}1

  if [[ "$DATA_PARTITION_FS" == "ext4" ]]; then
    parted $DATA_DISK mkpart primary ext4 1MiB 100%
    mkfs.ext4 $DATA_PARTITION
  else
    echo_warn "Data partition file system not supported: $DATA_PARTITION_FS"
  fi
fi

echo_info "Using data disk:     $DATA_DISK"
echo      "with data partition: $DATA_PARTITION"
