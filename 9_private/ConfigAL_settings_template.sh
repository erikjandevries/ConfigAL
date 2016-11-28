#### 1_linux ####

# Git
GIT_USER_NAME="John Doe"
GIT_USER_EMAIL="johndoe@email.com"



#### 2_www ####

# OpenSSH
OPENSSH_SERVER_PORT=22
OPENSSH_SERVER_PASSWORD_AUTHENTICATION=false



#### 3_db ####

# MariaDB
prompt_passwd "MariaDB" "root"
MARIADB_ROOT_PASSWORD=$PROMPT_PASSWD
PROMPT_PASSWD=
MARIADB_REMOVE_ANONYMOUS_USERS="y"
MARIADB_DISALLOW_REMOTE_ROOT_LOGIN="y"
MARIADB_REMOVE_TEST_DB="n"
MARIADB_RELOAD_PRIVILEGE_TABLES="y"
