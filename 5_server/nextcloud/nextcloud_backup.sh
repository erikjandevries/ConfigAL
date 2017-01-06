SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

echo_section "Creating backup of Nextcloud"

echo_subsection "Creating backup of files and folders"
ensure_dir $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/ -sudo

sudopw rsync -Aax ${NEXTCLOUD_ncpath}/config/ $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/config/
sudopw rsync -Aax ${NEXTCLOUD_ncpath}/themes/ $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/themes/
sudopw rsync -Aax ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/data/ $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/data/
sudopw rsync -Aax ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/assets/ $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/assets/

echo_subsection "Creating backup of database"
sudopw mysqldump --lock-tables -h localhost -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD "nextcloud" | sudo tee $NEXTCLOUD_BACKUP_DIR/nextcloud-sqlbkp.bak > /dev/null
