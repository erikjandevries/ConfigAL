pacman -S --noconfirm xorg-server xorg-xinit xorg-server-utils
pacman -S --noconfirm mesa

pacman -S --noconfirm cinnamon


# pacman -S --noconfirm gnome-common intltool gnome-doc-utils libdmx libgnomecanvas libwebkit
# wget https://aur.archlinux.org/cgit/aur.git/snapshot/mdm-display-manager.tar.gz
# tar xzf mdm-display-manager.tar.gz
# cd mdm-display-manager
# makepkg
# 
# pacman -U mdm-display-manager-2.0.10-1-x86_64.pkg.tar.xz
# 
# systemctl enable mdm
# # systemctl start mdm

pacman -S --noconfirm sddm
systemctl enable sddm
# systemctl start sddm
