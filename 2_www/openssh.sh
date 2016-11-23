echo_section "Installing OpenSSH"

pacman -S --noconfirm openssh
systemctl enable sshd.socket
systemctl start sshd.socket
