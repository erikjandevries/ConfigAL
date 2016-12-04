echo_section "Installing PHP"

ensure_pkg php php-apache

echo_subsection "Configuring Apache for PHP"
sudopw cp $CONFIGAL_CURRENT/4_php/config_files/info.php /srv/http/info.php

replace_conf "LoadModule mpm_event_module modules\/mod_mpm_event.so" "#LoadModule mpm_event_module modules\/mod_mpm_event.so" /etc/httpd/conf/httpd.conf -sudo
replace_conf "#LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so" "LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so" /etc/httpd/conf/httpd.conf -sudo

ensure_conf "LoadModule php7_module modules/libphp7.so" /etc/httpd/conf/httpd.conf -sudo
ensure_conf "Include conf/extra/php7_module.conf" /etc/httpd/conf/httpd.conf -sudo
ensure_conf "AddHandler php7-script php" /etc/httpd/conf/httpd.conf -sudo

sudopw systemctl restart httpd.service
