echo_section "Installing Python"

echo_subsection "Installing base development packages"
ensure_pkg base-devel

echo_subsection "Installing Python"
ensure_pkg python

echo_subsection "Installing Python setup tools"
ensure_pkg python-setuptools

echo_subsection "Installing pip"
ensure_pkg python-pip

if [[ -e /etc/pip.conf ]]; then
  echo_info "pip configuration file exists"
else
  echo_info "Creating pip configuration file"
  sudo tee /etc/pip.conf << EOF > /dev/null
[list]
format=columns
EOF
fi




echo_section "Installing Numpy (linked with OpenBLAS)"
install_pkg_aur python-numpy-openblas
install_pkg_aur python2-numpy-openblas

echo_section "Installing SciPy (linked with OpenBLAS)"
# install_pkg_aur python-scipy-openblas
ensure_git_clone https://aur.archlinux.org/python-scipy-openblas.git ~/.aur/python-scipy-openblas.git
CURRENT_DIR=$(pwd)
cd ~/.aur/python-scipy-openblas.git
makepkg -scf
AUR_PKG_FILE=$(ls python-scipy-openblas*.tar.xz)
sudopw pacman -U --needed --noconfirm --color auto ~/.aur/python-scipy-openblas.git/$AUR_PKG_FILE
AUR_PKG_FILE=$(ls python2-scipy-openblas*.tar.xz)
sudopw pacman -U --needed --noconfirm --color auto ~/.aur/python-scipy-openblas.git/$AUR_PKG_FILE
cd $CURRENT_DIR

echo_section "Installing Pillow"
ensure_pkg python-pillow
ensure_pkg python2-pillow

echo_section "Installing Pandas"
ensure_pkg python-pandas
ensure_pkg python2-pandas

echo_section "Installing Matplotlib"
ensure_pkg python-matplotlib
ensure_pkg python2-matplotlib
