#### 1_linux ####

# xorg
XORG_SET_SCREEN_RESOLUTION=false
XORG_ADD_SCREEN_RESOLUTION=false
XORG_ADD_SCREEN_RESOLUTION_WIDTH=1280
XORG_ADD_SCREEN_RESOLUTION_HEIGHT=1024
XORG_ADD_SCREEN_RESOLUTION_DRIVER=intel

# Git
GIT_USER_NAME="My Name"
GIT_USER_EMAIL="myname@email.com"

# KDE
KDE_ALL_APPLICATIONS=true

# GNOME
GNOME_ALL_APPLICATIONS=true

#### 2_www ####

# OpenSSH
OPENSSH_SERVER_PORT=22
OPENSSH_SERVER_PASSWORD_AUTHENTICATION=false

# nginx
NGINX_DOMAIN_NAME="my.domain.com"
NGINX_SSL_O="My Organisation"
NGINX_SSL_OU="Unit"
NGINX_SSL_CN=$NGINX_DOMAIN_NAME

# Apache
APACHE_DOMAIN_NAME=$NGINX_DOMAIN_NAME
APACHE_PORT=8080
APACHE_SERVER_ADMIN=you@example.com



#### 3_db ####

# MariaDB
prompt_passwd "MariaDB" "root"
MARIADB_ROOT_PASSWORD=$PROMPT_PASSWD
PROMPT_PASSWD=
MARIADB_REMOVE_ANONYMOUS_USERS="y"
MARIADB_DISALLOW_REMOTE_ROOT_LOGIN="y"
MARIADB_REMOVE_TEST_DB="n"
MARIADB_RELOAD_PRIVILEGE_TABLES="y"



#### 5_server ####

# # OwnCloud
# OWNCLOUD_ocpath='/usr/share/webapps/owncloud'
# OWNCLOUD_ocpath_DATA="data"
# OWNCLOUD_ocpath_ASSETS="assets"
# OWNCLOUD_htuser='http'
# OWNCLOUD_htgroup='http'
# OWNCLOUD_rootuser='root'
# OWNCLOUD_oc_admin_user='admin'
# prompt_passwd "ownCloud" "$OWNCLOUD_oc_admin_user"
# OWNCLOUD_oc_admin_pass=$PROMPT_PASSWD

# Nextcloud
NEXTCLOUD_ncpath='/usr/share/webapps/nextcloud'
NEXTCLOUD_ncpath_DATA="data"
NEXTCLOUD_ncpath_ASSETS="assets"
NEXTCLOUD_htuser='http'
NEXTCLOUD_htgroup='http'
NEXTCLOUD_rootuser='root'
NEXTCLOUD_nc_admin_user='admin'
prompt_passwd "Nextcloud" "$NEXTCLOUD_nc_admin_user"
NEXTCLOUD_nc_admin_pass=$PROMPT_PASSWD

NEXTCLOUD_BACKUP_DIR=$DATA_PARTITION_MOUNT_FOLDER/.backups/nextcloud

# VLC
VLC_HTTP_PORT=8090
prompt_passwd "VLC" "web service"
VLC_HTTP_PASSWORD=$PROMPT_PASSWD
