echo_section "Installing SDDM desktop manager"

pacman -S --noconfirm sddm
systemctl enable sddm
# systemctl start sddm
