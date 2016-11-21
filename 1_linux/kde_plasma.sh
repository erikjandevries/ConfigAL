pacman -S --noconfirm xorg-server xorg-xinit xorg-server-utils
pacman -S --noconfirm mesa
pacman -S --noconfirm plasma
pacman -S --noconfirm sddm
systemctl enable sddm
# systemctl start sddm
