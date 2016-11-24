echo_section "Installing SDDM desktop manager"

install_pkg sddm
systemctl enable sddm
# systemctl start sddm
