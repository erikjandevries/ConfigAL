echo_section "Configuring standard folder structure"

ensure_dir ~/Repositories
ensure_dir ~/Software
ensure_dir ~/VirtualEnvs

ensure_dir ~/R
ensure_dir ~/.ssh

ensure_sl $DATA_PARTITION_MOUNT_FOLDER ~/datadisk
