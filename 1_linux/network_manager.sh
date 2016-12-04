echo_section "Enabling Network Manager"

ensure_pkg networkmanager

systemctl enable NetworkManager
systemctl start NetworkManager
