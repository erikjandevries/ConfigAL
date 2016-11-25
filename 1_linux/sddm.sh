echo_section "Installing SDDM desktop manager"

ensure_pkg sddm
sudopw systemctl enable sddm
