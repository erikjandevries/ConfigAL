echo_section "Installing Nextcloud"

echo_subsection "Creating directory structures"
ensure_dir "${NEXTCLOUD_ncpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS" -sudo

echo_subsection "Installing Nextcloud"
gpg --recv-key D75899B9A724937A
install_pkg_aur nextcloud

echo_warn "Creating symlinks"
sudopw rmdir "${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA"
sudopw rmdir "${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS"
ensure_sl "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA" "${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA" -sudo
ensure_sl "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS" "${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS" -sudo

ensure_pkg php php-apache php-gd php-intl php-mcrypt

# Uncomment the following required extensions in /etc/php/php.ini:
replace_conf ";extension=bz2.so" "extension=bz2.so" /etc/php/php.ini -sudo
replace_conf ";extension=curl.so" "extension=curl.so" /etc/php/php.ini -sudo
replace_conf ";extension=gd.so" "extension=gd.so" /etc/php/php.ini -sudo
replace_conf ";extension=iconv.so" "extension=iconv.so" /etc/php/php.ini -sudo
replace_conf ";extension=xmlrpc.so" "extension=xmlrpc.so" /etc/php/php.ini -sudo
replace_conf ";extension=zip.so" "extension=zip.so" /etc/php/php.ini -sudo

# It is also recommended to install php-intl, php-mcrypt and uncomment the following extensions:
replace_conf ";extension=intl.so" "extension=intl.so" /etc/php/php.ini -sudo
replace_conf ";extension=mcrypt.so" "extension=mcrypt.so" /etc/php/php.ini -sudo

# Using MySQL or MariaDB
replace_conf ";extension=pdo_mysql.so" "extension=pdo_mysql.so" /etc/php/php.ini -sudo


echo_subsection "Nextcloud security hardening"
printf "chmod Files and Directories\n"
sudo find "${NEXTCLOUD_ncpath}/" -type f -print0 | sudo xargs -0 chmod 0640
sudo find "${NEXTCLOUD_ncpath}/" -type d -print0 | sudo xargs -0 chmod 0750

printf "chown Directories\n"
sudopw chown -R ${NEXTCLOUD_rootuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/
sudopw chown -R ${NEXTCLOUD_rootuser}:${NEXTCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/
sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/apps/
sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/config/
sudopw chown -h ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA
sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA/
sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/themes/
sudopw chown -h ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS
sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_ASSETS/
sudopw chmod +x ${NEXTCLOUD_ncpath}/occ

printf "chmod/chown .htaccess\n"
if [ -f ${NEXTCLOUD_ncpath}/.htaccess ]
 then
  chmod 0644 ${NEXTCLOUD_ncpath}/.htaccess
  chown ${NEXTCLOUD_rootuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/.htaccess
fi
if [ -f ${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA/.htaccess ]
 then
  chmod 0644 ${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA/.htaccess
  chown ${NEXTCLOUD_rootuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA/.htaccess
fi


echo_subsection "Setup Apache"
sudopw cp /etc/webapps/nextcloud/apache.example.conf /etc/httpd/conf/extra/nextcloud.conf

# Add folders to php's open_basedir?

echo "Include conf/extra/nextcloud.conf" | sudo tee -a /etc/httpd/conf/httpd.conf



echo_subsection "Make Nextcloud accessible on the website (via symlink)"
sudopw ln -s "${NEXTCLOUD_ncpath}/" "/srv/http/nextcloud"
sudopw systemctl restart httpd.service


#echo_subsection "Switch to Cron from AJAX"
#ensure_pkg cronie


echo_subsection "Creating database"
mysql -u root -p${MARIADB_ROOT_PASSWORD} < $CONFIGAL_CURRENT/5_server/nextcloud/nextcloud_create_db.sql


echo_subsection "Configuring Nextcloud"
sudo -u http php /srv/http/nextcloud/occ maintenance:install \
  --database "mysql" \
  --database-name "nextcloud" \
  --database-user "root" \
  --database-pass "$MARIADB_ROOT_PASSWORD" \
  --admin-user "$NEXTCLOUD_nc_admin_user" \
  --admin-pass "$NEXTCLOUD_nc_admin_pass" \
  --data-dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/$NEXTCLOUD_ncpath_DATA"
