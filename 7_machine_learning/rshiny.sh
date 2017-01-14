echo_section "Installing R Shiny Server"

install_pkg_aur shiny-server-git

sudopw systemctl enable shiny-server
sudopw systemctl start shiny-server
