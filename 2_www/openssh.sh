echo_section "Installing OpenSSH"

ensure_pkg openssh
sudopw systemctl enable sshd.socket
sudopw systemctl start sshd.socket
