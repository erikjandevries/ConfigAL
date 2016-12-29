echo_section "Installing ownCloud"

ensure_pkg owncloud

# Uncomment the following required extensions in /etc/php/php.ini:
replace_conf "#gd.so" "gd.so" /etc/php/php.ini -sudo
replace_conf "#iconv.so" "iconv.so" /etc/php/php.ini -sudo
replace_conf "#xmlrpc.so" "xmlrpc.so" /etc/php/php.ini -sudo
replace_conf "#zip.so" "zip.so" /etc/php/php.ini -sudo

# It is also recommended to install php-intl, php-mcrypt and uncomment the following extensions:
replace_conf "#bz2.so" "bz2.so" /etc/php/php.ini -sudo
replace_conf "#curl.so" "curl.so" /etc/php/php.ini -sudo
replace_conf "#intl.so" "intl.so" /etc/php/php.ini -sudo
replace_conf "#mcrypt.so" "mcrypt.so" /etc/php/php.ini -sudo


echo_subsection "OwnCloud security hardening"
ocpath='/usr/share/webapps/owncloud'
htuser='http'
htgroup='http'
rootuser='root'

printf "Creating possible missing Directories\n"
mkdir -p $ocpath/data
mkdir -p $ocpath/assets

printf "chmod Files and Directories\n"
find ${ocpath}/ -type f -print0 | xargs -0 chmod 0640
find ${ocpath}/ -type d -print0 | xargs -0 chmod 0750

printf "chown Directories\n"
chown -R ${rootuser}:${htgroup} ${ocpath}/
chown -R ${htuser}:${htgroup} ${ocpath}/apps/
chown -R ${htuser}:${htgroup} ${ocpath}/config/
chown -R ${htuser}:${htgroup} ${ocpath}/data/
chown -R ${htuser}:${htgroup} ${ocpath}/themes/
chown -R ${htuser}:${htgroup} ${ocpath}/assets/

chmod +x ${ocpath}/occ

printf "chmod/chown .htaccess\n"
if [ -f ${ocpath}/.htaccess ]
 then
  chmod 0644 ${ocpath}/.htaccess
  chown ${rootuser}:${htgroup} ${ocpath}/.htaccess
fi
if [ -f ${ocpath}/data/.htaccess ]
 then
  chmod 0644 ${ocpath}/data/.htaccess
  chown ${rootuser}:${htgroup} ${ocpath}/data/.htaccess
fi
