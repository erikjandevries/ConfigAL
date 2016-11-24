echo_section "Installing SDDM desktop manager"

if [[ "x$(pacman -Qs atom)" == "x" ]]; then
  install_pkg sddm
  systemctl enable sddm
else
  echo_info "SDDM desktop manager has already been installed"
fi
