SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

source $SCRIPTPATH/../../9_private/InstallAL_settings.sh
source $SCRIPTPATH/../../9_private/ConfigAL_settings.sh

if [[ -d $NEXTCLOUD_BACKUP_DIR ]]; then

  echo_section "Restoring Nextcloud"

  echo_subsection "Restoring files and folders"
  ensure_dir ${NEXTCLOUD_ncpath} -sudo

  sudopw rsync -Aax $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/config/ ${NEXTCLOUD_ncpath}/config/
  sudopw rsync -Aax $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/themes/ ${NEXTCLOUD_ncpath}/themes/
  sudopw rsync -Aax $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/data/ ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/data/
  sudopw rsync -Aax $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/assets/ ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/assets/


  echo_subsection "Restoring database"
  echo_info "Cleaning up database"
  mysql -h localhost -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD -e "DROP DATABASE nextcloud"
  mysql -h localhost -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE nextcloud"

  echo_info "Restoring database"
  mysql -h localhost -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD "nextcloud" < $NEXTCLOUD_BACKUP_DIR/nextcloud-sqlbkp.bak

  source $SCRIPTPATH/nextcloud_security_hardening.sh

else
  echo_warn "Nextcloud backup not found!"
fi
