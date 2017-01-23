echo_section "Configuring standard folder structure"

ensure_dir ~/Repositories
ensure_dir ~/Software
ensure_dir ~/VirtualEnvs
ensure_dir ~/VirtualMachines

ensure_dir ~/R
ensure_dir ~/.ssh

ensure_sl $DATA_PARTITION_MOUNT_FOLDER ~/datadisk


echo_section "Adding ConfigAL common functions to .bashrc"
ensure_dir ~/.bash_functions
cp $CONFIGAL_CURRENT/ConfigAL_functions.sh ~/.bash_functions
ensure_conf 'source ~/.bash_functions/ConfigAL_functions.sh' ~/.bashrc
