SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

source $SCRIPTPATH/../../9_private/InstallAL_settings.sh
source $SCRIPTPATH/../../9_private/ConfigAL_settings.sh

ensure_dir $NEXTCLOUD_BACKUP_DIR

echo_section "Creating backup of Nextcloud"

echo_subsection "Creating backup of files and folders"
sudopw rsync -Aax ${NEXTCLOUD_ncpath}/ $NEXTCLOUD_BACKUP_DIR/nextcloud-dirbkp/

echo_subsection "Creating backup of database"
mysqldump --lock-tables -h $OS_HOSTNAME -u $NEXTCLOUD_rootuser -p$MARIADB_ROOT_PASSWORD "nextcloud" > nextcloud-sqlbkp.bak
