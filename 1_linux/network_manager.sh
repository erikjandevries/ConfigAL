echo_section "Installing Network Manager"

ensure_pkg networkmanager

echo_section "Enabling and starting Network Manager"

sudopw systemctl enable NetworkManager
sudopw systemctl start NetworkManager
