SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

echo_section "Removing backup of Nextcloud"
sudopw rm -rf ${NEXTCLOUD_BACKUP_DIR}
