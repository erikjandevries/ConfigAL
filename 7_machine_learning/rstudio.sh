echo_section "Installing RStudio Server"

# echo_subsection "Installing binary build"
# install_pkg_aur rstudio-server-bin
# sudopw touch /etc/rstudio/rserver.conf
# sudopw touch /etc/rstudio/rsession.conf

echo_subsection "Installing latest version from Git repository"
ensure_pkg wget
#ensure_git_clone https://aur.archlinux.org/rstudio-server-git.git ~/.aur/rstudio-server-git.git
#RSTUDIO_VERSION=$(cat PKGBUILD | grep "pkgver=" | awk -F'[=&]' '{print $2}')
#RSTUDIO_VERSION_MAJOR=
#RSTUDIO_VERSION_MINOR=
#RSTUDIO_VERSION_PATCH=
install_pkg_aur rstudio-server-git

sudopw systemctl enable rstudio-server
sudopw systemctl start rstudio-server
