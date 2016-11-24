echo_section "Installing OpenSSH"

if [[ "x$(pacman -Qs atom)" == "x" ]]; then
  install_pkg openssh
  systemctl enable sshd.socket
  systemctl start sshd.socket
else
  echo_info "OpenSSH has already been installed"
fi
