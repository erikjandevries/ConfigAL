echo_section "Installing Nextcloud"
SCRIPTPATH=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

echo_subsection "Creating directory structures"
ensure_dir "${NEXTCLOUD_ncpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}" -sudo
ensure_dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_ASSETS}" -sudo

echo_subsection "Installing Nextcloud"
gpg --keyserver hkp://pool.sks-keyservers.net --recv-key D75899B9A724937A
install_pkg_aur nextcloud

echo_warn "Creating symlinks"
sudopw rmdir "${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}"
sudopw rmdir "${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_ASSETS}"
ensure_sl "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}" "${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}" -sudo
ensure_sl "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_ASSETS}" "${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_ASSETS}" -sudo

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


source ${SCRIPTPATH}/nextcloud_security_hardening.sh


echo_subsection "Setup Apache"
sudopw cp /etc/webapps/nextcloud/apache.example.conf /etc/httpd/conf/extra/nextcloud.conf

# Add folders to php's open_basedir?

echo "Include conf/extra/nextcloud.conf" | sudo tee -a /etc/httpd/conf/httpd.conf



echo_subsection "Make Nextcloud accessible on the website (via symlink)"
sudopw ln -s "${NEXTCLOUD_ncpath}/" "/srv/http/nextcloud"
sudopw systemctl restart httpd.service


#echo_subsection "Switch to Cron from AJAX"
#ensure_pkg cronie


NEXTCLOUD_BACKUP_RESTORED="false"
if [[ "${NEXTCLOUD_RESTORE_BACKUP_IF_AVAILABLE}" == "true" ]]; then
  if [[ -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/config &&
        -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/themes &&
        -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/data &&
        -d ${NEXTCLOUD_BACKUP_DIR}/nextcloud-dirbkp/assets &&
        -f ${NEXTCLOUD_BACKUP_DIR}/nextcloud-sqlbkp.bak
  ]]; then
    source ${SCRIPTPATH}/nextcloud_restore.sh
    NEXTCLOUD_BACKUP_RESTORED="true"
  else
    echo_warn "Backup of Nextcloud not found"
  fi
fi

if [[ "${NEXTCLOUD_BACKUP_RESTORED}" == "false" ]]; then
  echo_subsection "Creating database"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS nextcloud;"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "CREATE USER 'nc_${NEXTCLOUD_nc_admin_user}'@'localhost' IDENTIFIED BY '${NEXTCLOUD_nc_admin_pass}';"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nc_${NEXTCLOUD_nc_admin_user}'@'localhost' IDENTIFIED BY '${NEXTCLOUD_nc_admin_pass}';"
  mysql -h localhost -u ${NEXTCLOUD_rootuser} -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

  echo_subsection "Configuring Nextcloud"
  sudo -u http php /srv/http/nextcloud/occ maintenance:install \
    --database "mysql" \
    --database-name "nextcloud" \
    --database-user "nc_${NEXTCLOUD_nc_admin_user}" \
    --database-pass "${NEXTCLOUD_nc_admin_pass}" \
    --admin-user "${NEXTCLOUD_nc_admin_user}" \
    --admin-pass "${NEXTCLOUD_nc_admin_pass}" \
    --data-dir "${DATA_PARTITION_MOUNT_FOLDER}${NEXTCLOUD_ncpath}/${NEXTCLOUD_ncpath_DATA}"

  echo_info "Adding hostname to trusted domains"
  # replace_conf "'trusted_domains' => \n  array (\n    0 => 'localhost',\n  )," "'trusted_domains' => \n  array (\n    0 => 'localhost',\n    1 => 'localhost',\n  )," /usr/share/webapps/nextcloud/config/config.php -sudo
  replace_conf "    0 => 'localhost'," "    0 => 'localhost',\n    1 => '${NGINX_DOMAIN_NAME}'," /usr/share/webapps/nextcloud/config/config.php -sudo
  sudopw chown -R ${NEXTCLOUD_htuser}:${NEXTCLOUD_htgroup} ${NEXTCLOUD_ncpath}/config/
fi
