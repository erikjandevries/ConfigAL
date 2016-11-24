echo_section "Installing OpenSSH"

install_pkg openssh
systemctl enable sshd.socket
systemctl start sshd.socket
