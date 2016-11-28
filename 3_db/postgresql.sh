# echo_section "Installing PostgreSQL"
# if [ $(dpkg-query -W -f='${Status}' postgresql 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
#   ensure_conf 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' /etc/apt/sources.list.d/pgdg.list -sudo
#
#   wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#   sudo apt-get update
#
#   # ensure_pkg postgresql-9.4-postgis-2.1 postgresql-9.4 postgresql-contrib-9.4 pgadmin3
#   ensure_pkg postgresql postgresql-contrib postgis pgadmin3
#   # See: http://wiki.openstreetmap.org/wiki/PostGIS/Installation
# else
#   echo_info "PostgreSQL is already installed";
# fi
#
# echo_subsection "Installing PostgreSQL SDBC driver for LibreOffice"
# ensure_pkg libreoffice-sdbc-postgresql
