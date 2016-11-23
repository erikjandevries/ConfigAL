echo_section "Installing Firefox web browser"

pacman -S --noconfirm openssh
systemctl enable sshd.socket
systemctl start sshd.socket
