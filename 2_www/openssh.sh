echo_section "Installing OpenSSH"

ensure_pkg openssh
if [[ ! -e /etc/ssh/sshd_config.defaults ]]; then
  echo_info "Creating backup copy of the configuration file"
  sudopw cp /etc/ssh/sshd_config /etc/ssh/sshd_config.defaults
else
  echo_info "Backup copy of default configuration file already exists"
fi


if [[ "${OPENSSH_SERVER_PASSWORD_AUTHENTICATION}" == "true" ]]; then
  echo_subsection "Configuring OpenSSH Server to allow password authentication"
  replace_conf "PasswordAuthentication no" "PasswordAuthentication yes" /etc/ssh/sshd_config -sudo
  replace_conf "#PasswordAuthentication no" "PasswordAuthentication yes" /etc/ssh/sshd_config -sudo
  replace_conf "#PasswordAuthentication yes" "PasswordAuthentication yes" /etc/ssh/sshd_config -sudo
else
  echo_subsection "Configuring OpenSSH Server for authentication with keys only"
  replace_conf "PasswordAuthentication yes" "PasswordAuthentication no" /etc/ssh/sshd_config -sudo
  replace_conf "#PasswordAuthentication yes" "PasswordAuthentication no" /etc/ssh/sshd_config -sudo
  replace_conf "#PasswordAuthentication no" "PasswordAuthentication no" /etc/ssh/sshd_config -sudo
fi


echo_subsection "Setting default port for OpenSSH Server"
# Changing the default port: Good or bad?
# https://danielmiessler.com/blog/putting-ssh-another-port-good-idea/
# https://major.io/2013/05/14/changing-your-ssh-servers-port-from-the-default-is-it-worth-it/
sudo grep -q -F "Port ${OPENSSH_SERVER_PORT}" /etc/ssh/sshd_config || sudo sed -i "s/#Port 22/Port ${OPENSSH_SERVER_PORT}/" /etc/ssh/sshd_config

ensure_dir /etc/systemd/system/sshd.socket.d -sudo
sudo tee /etc/systemd/system/sshd.socket.d/override.conf << EOF > /dev/null
[Socket]
ListenStream=
ListenStream=${OPENSSH_SERVER_PORT}
EOF
sudopw systemctl daemon-reload

echo_subsection "Starting OpenSSH Server"
sudopw systemctl enable sshd.socket
sudopw systemctl start sshd.socket
