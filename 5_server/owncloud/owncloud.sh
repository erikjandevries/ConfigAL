echo_section "Installing ownCloud"

echo_subsection "Creating directory structures"
ensure_dir "${OWNCLOUD_ocpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_ASSETS" -sudo

echo_warn "Creating symlinks - code to be checked/fixed"
sudopw ln -s "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA" "${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA"
sudopw ln -s "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_ASSETS" "${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_ASSETS"

echo_subsection "Installing ownCloud"
ensure_pkg owncloud

ensure_pkg php php-apache php-intl php-mcrypt

# Uncomment the following required extensions in /etc/php/php.ini:
replace_conf ";extension=gd.so" "extension=gd.so" /etc/php/php.ini -sudo
replace_conf ";extension=iconv.so" "extension=iconv.so" /etc/php/php.ini -sudo
replace_conf ";extension=xmlrpc.so" "extension=xmlrpc.so" /etc/php/php.ini -sudo
replace_conf ";extension=zip.so" "extension=zip.so" /etc/php/php.ini -sudo

# It is also recommended to install php-intl, php-mcrypt and uncomment the following extensions:
replace_conf ";extension=bz2.so" "extension=bz2.so" /etc/php/php.ini -sudo
replace_conf ";extension=curl.so" "extension=curl.so" /etc/php/php.ini -sudo
replace_conf ";extension=intl.so" "extension=intl.so" /etc/php/php.ini -sudo
replace_conf ";extension=mcrypt.so" "extension=mcrypt.so" /etc/php/php.ini -sudo

# Using MySQL or MariaDB
replace_conf ";extension=pdo_mysql.so" "extension=pdo_mysql.so" /etc/php/php.ini -sudo


echo_subsection "OwnCloud security hardening"
printf "chmod Files and Directories\n"
sudo find "${OWNCLOUD_ocpath}/" -type f -print0 | sudo xargs -0 chmod 0640
sudo find "${OWNCLOUD_ocpath}/" -type d -print0 | sudo xargs -0 chmod 0750

printf "chown Directories\n"
sudopw chown -R ${OWNCLOUD_rootuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/
sudopw chown -R ${OWNCLOUD_rootuser}:${OWNCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/
sudopw chown -R ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/apps/
sudopw chown -R ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/config/
sudopw chown -h ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA
sudopw chown -R ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA/
sudopw chown -R ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/themes/
sudopw chown -h ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_ASSETS
sudopw chown -R ${OWNCLOUD_htuser}:${OWNCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_ASSETS/
sudopw chmod +x ${OWNCLOUD_ocpath}/occ

printf "chmod/chown .htaccess\n"
if [ -f ${OWNCLOUD_ocpath}/.htaccess ]
 then
  chmod 0644 ${OWNCLOUD_ocpath}/.htaccess
  chown ${OWNCLOUD_rootuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/.htaccess
fi
if [ -f ${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA/.htaccess ]
 then
  chmod 0644 ${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA/.htaccess
  chown ${OWNCLOUD_rootuser}:${OWNCLOUD_htgroup} ${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA/.htaccess
fi

echo_subsection "Make OwnCloud accessible on the website (via symlink)"
sudopw ln -s "${OWNCLOUD_ocpath}/" "/srv/http/owncloud"
sudopw systemctl restart httpd.service


echo_subsection "Configuring ownCloud"
CURRENT_DIR=$(pwd)
cd /srv/http/owncloud/

sudo -u http php occ maintenance:install \
  --database "mysql" \
  --database-name "owncloud" \
  --database-user "root" \
  --database-pass "$MARIADB_ROOT_PASSWORD" \
  --admin-user "$OWNCLOUD_oc_admin_user" \
  --admin-pass "$OWNCLOUD_oc_admin_pass" \
  --data-dir "${DATA_PARTITION_MOUNT_FOLDER}${OWNCLOUD_ocpath}/$OWNCLOUD_ocpath_DATA"

cd $CURRENT_DIR
