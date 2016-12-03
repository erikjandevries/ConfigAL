echo_section "Installing nginx"

ensure_pkg nginx-mainline

echo_subsection "Setting up SSL key"
ensure_dir /etc/nginx/ssl -sudo
if [[ ! -e /etc/nginx/ssl/nginx.key ]]; then
  if [[ ! -e ~/.ssh/nginx.key ]]; then
    sudopw openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/O=$NGINX_SSL_O/OU=$NGINX_SSL_OU/CN=$NGINX_SSL_CN" -keyout ~/.ssh/nginx.key -out ~/.ssh/nginx.crt
    sudopw chmod 600 ~/.ssh/nginx.key
    sudopw chmod 600 ~/.ssh/nginx.crt
    # sudopw chown root:root ~/.ssh/nginx.key
    # sudopw chown root:root ~/.ssh/nginx.crt
  fi
  sudopw cp ~/.ssh/nginx.key /etc/nginx/ssl/nginx.key
  sudopw cp ~/.ssh/nginx.crt /etc/nginx/ssl/nginx.crt
fi

echo_subsection "Configuring sites"
sudopw cp $CONFIGAL_CURRENT/2_www/config_files/nginx.conf /etc/nginx/nginx.conf
replace_conf "      server_name your_domain.com;" "      server_name $NGINX_DOMAIN_NAME;" /etc/nginx/nginx.conf -sudo

echo_subsection "Starting nginx Server"
sudopw systemctl enable nginx.service
sudopw systemctl restart nginx.service
