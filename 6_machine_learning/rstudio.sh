echo_section "Installing RStudio Server"

install_pkg_aur rstudio-server-git

sudopw touch /etc/rstudio/rserver.conf
sudopw touch /etc/rstudio/rsession.conf

sudopw systemctl enable rstudio-server
