echo_section "Removing Nextcloud"

echo_subsection "Uninstalling package"
sudopw pacman -R --noconfirm nextcloud

echo_subsection "Removing directory"
sudopw rm -rf /srv/http/nextcloud
sudopw rm -rf ${NEXTCLOUD_ncpath}
sudopw rm -rf ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}
sudopw rm -rf ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}
sudopw rm -rf ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_ASSETS}

echo_subsection "Removing database"
mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "DROP DATABASE IF EXISTS nextcloud"
mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE user LIKE 'nc_%';"
