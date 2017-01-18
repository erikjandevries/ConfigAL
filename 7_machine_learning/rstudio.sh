echo_section "Installing RStudio Server"

echo_info "Making sure wget is installed"
ensure_pkg wget

# echo_subsection "Installing binary build"
# install_pkg_aur rstudio-server-bin
# sudopw touch /etc/rstudio/rserver.conf
# sudopw touch /etc/rstudio/rsession.conf


# To set the version number in RStudio Server, run the following before compiling/installing.
# Otherwise, the version number will be 99.9.9.
#
# echo_subsection "Cloning/pulling latest version from Git repository"
# ensure_git_clone https://aur.archlinux.org/rstudio-server-git.git ~/.aur/rstudio-server-git.git
# 
# echo_info "Determining version number"
# RSTUDIO_VERSION=$(cat ~/.aur/rstudio-server-git.git/PKGBUILD | grep "pkgver=" | awk -F'[=&]' '{print $2}')
# RSTUDIO_VERSION=${RSTUDIO_VERSION:1}
# export RSTUDIO_VERSION_MAJOR=$(echo $RSTUDIO_VERSION | awk -F'[.&]' '{print $1}')
# export RSTUDIO_VERSION_MINOR=$(echo $RSTUDIO_VERSION | awk -F'[.&]' '{print $2}')
# export RSTUDIO_VERSION_PATCH=$(echo $RSTUDIO_VERSION | awk -F'[.&]' '{print $3}')

echo_subsection "Installing RStudio Server"
install_pkg_aur rstudio-server-git

sudopw systemctl enable rstudio-server
sudopw systemctl start rstudio-server
