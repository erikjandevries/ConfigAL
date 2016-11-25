echo_section "Installing OpenSSH"

if [[ "x$(pacman -Qs openssh)" == "x" ]]; then
  install_pkg openssh
  sudopw systemctl enable sshd.socket
  sudopw systemctl start sshd.socket
else
  echo_info "OpenSSH has already been installed"
fi
