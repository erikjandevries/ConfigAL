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
