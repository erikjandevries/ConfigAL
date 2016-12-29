echo_section "Installing RStudio Server"

install_pkg_aur rstudio-server-bin

# sudopw touch /etc/rstudio/rserver.conf
# sudopw touch /etc/rstudio/rsession.conf

sudopw systemctl enable rstudio-server
sudopw systemctl start rstudio-server
