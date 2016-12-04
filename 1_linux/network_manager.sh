echo_section "Enabling Network Manager"

ensure_pkg networkmanager

sudopw systemctl enable NetworkManager
sudopw systemctl start NetworkManager
