SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

source $SCRIPTPATH/../../9_private/InstallAL_settings.sh
source $SCRIPTPATH/../../9_private/ConfigAL_settings.sh

if [[ -d $NEXTCLOUD_BACKUP_DIR ]]; then

  echo_section "Restoring Nextcloud"

  echo_subsection "Restoring files and folders"
  sudopw rm -rf ${NEXTCLOUD_ncpath}
  ensure_dir ${NEXTCLOUD_ncpath} -sudo
  sudopw rsync -Aax $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/ ${NEXTCLOUD_ncpath}/

  echo_subsection "Restoring database"
  echo_info "Cleaning up database"
  mysql -h $OS_HOSTNAME -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD -e "DROP DATABASE nextcloud"
  mysql -h $OS_HOSTNAME -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD -e "CREATE DATABASE nextcloud"

  echo_info "Restoring database"
  mysql -h $OS_HOSTNAME -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD "nextcloud" < nextcloud-sqlbkp.bak


  source $SCRIPTPATH/nextcloud_security_hardening.sh

else
  echo_warn "Nextcloud backup not found!"
fi
