echo_section "Installing SDDM desktop manager"

if [[ "x$(pacman -Qs sddm)" == "x" ]]; then
  install_pkg sddm
  sudopw systemctl enable sddm
else
  echo_info "SDDM desktop manager has already been installed"
fi
