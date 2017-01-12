# echo_section "Installing MariaDB Client"
# ensure_pkg mariadb-client
#
echo_section "Installing MariaDB Server"

if (pacman -Qi mariadb > /dev/null 2>&1); then
  echo_info "MariaDB Server is already installed";
else
  ensure_pkg mariadb

  echo_subsection "Installing system db"
  sudopw systemctl stop mysqld
  sudopw mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

  echo_subsection "Starting service"
  sudopw systemctl enable mysqld
  sudopw systemctl start mysqld

  echo_subsection "Setting root password"
  /usr/bin/mysqladmin -u root password "${MARIADB_ROOT_PASSWORD}"
  /usr/bin/mysqladmin -u root -h ${OS_HOSTNAME} password "${MARIADB_ROOT_PASSWORD}"

  echo_subsection "Securing installation"
  export MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}
  export MARIADB_REMOVE_ANONYMOUS_USERS=${MARIADB_REMOVE_ANONYMOUS_USERS}
  export MARIADB_DISALLOW_REMOTE_ROOT_LOGIN=${MARIADB_DISALLOW_REMOTE_ROOT_LOGIN}
  export MARIADB_REMOVE_TEST_DB=${MARIADB_REMOVE_TEST_DB}
  export MARIADB_RELOAD_PRIVILEGE_TABLES=${MARIADB_RELOAD_PRIVILEGE_TABLES}
  # mysql_secure_installation
  ${CONFIGAL_CURRENT}/3_db/mysql_secure_installation_10.1_automated
fi
