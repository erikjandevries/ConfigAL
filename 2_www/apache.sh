echo_section "Installing Apache www-server"

ensure_pkg apache

echo_subsection "Configuring sites"
replace_conf "#ServerName www.example.com:80" "ServerName $APACHE_DOMAIN_NAME" /etc/httpd/conf/httpd.conf -sudo
ensure_conf "ServerName $APACHE_DOMAIN_NAME" /etc/httpd/conf/httpd.conf -sudo
replace_conf "Listen 80" "Listen $APACHE_PORT" /etc/httpd/conf/httpd.conf -sudo
replace_conf "ServerAdmin you@example.com" "ServerAdmin $APACHE_SERVER_ADMIN" /etc/httpd/conf/httpd.conf -sudo


echo_subsection "Starting Apache www-server"
sudopw systemctl enable  httpd.service
sudopw systemctl restart httpd.service
