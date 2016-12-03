#### 1_linux ####

# Git
GIT_USER_NAME="My Name"
GIT_USER_EMAIL="myname@email.com"



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
