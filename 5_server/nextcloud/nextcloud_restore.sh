SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

if [[ -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/config &&
      -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/themes &&
      -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/data &&
      -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/assets &&
      -f ${NEXTCLOUD_BACKUP_DIR}/nextcloud-sqlbkp.bak
   ]]; then

  echo_section "Restoring Nextcloud"

  echo_subsection "Restoring files and folders"
  ensure_dir ${NEXTCLOUD_ncpath} -sudo
  ensure_dir ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath} -sudo

  sudopw rm -rf ${NEXTCLOUD_ncpath}/config/
  sudopw rm -rf ${NEXTCLOUD_ncpath}/themes/
  sudopw rm -rf ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/data/
  sudopw rm -rf ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/assets/

  sudopw rsync -Aax ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/config/ ${NEXTCLOUD_ncpath}/config/
  sudopw rsync -Aax ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/themes/ ${NEXTCLOUD_ncpath}/themes/
  sudopw rsync -Aax ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/data/ ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/data/
  sudopw rsync -Aax ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/assets/ ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/assets/


  echo_subsection "Restoring database"
  echo_info "Cleaning up database"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "DROP DATABASE IF EXISTS nextcloud"

  echo_info "Restoring database"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS nextcloud;"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER 'nc_${NEXTCLOUD_nc_admin_user}'@'localhost' IDENTIFIED BY '${NEXTCLOUD_nc_admin_pass}';"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nc_${NEXTCLOUD_nc_admin_user}'@'localhost' IDENTIFIED BY '${NEXTCLOUD_nc_admin_pass}';"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} "nextcloud" < ${NEXTCLOUD_BACKUP_DIR}/nextcloud-sqlbkp.bak

  source ${SCRIPTPATH}/nextcloud_security_hardening.sh

else
  echo_warn "Nextcloud backup not found!"
fi
