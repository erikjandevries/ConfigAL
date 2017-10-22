echo_section "Installing XGBoost"

echo_subsection "Installing XGBoost shared libraries"
install_pkg_aur xgboost-git

echo_subsection "Installing XGBoost Python packages"
AUR_PKG_FILE=$(ls ~/.aur/xgboost-git.git/python-*.tar.xz)
sudopw pacman -U --needed --noconfirm --color auto $AUR_PKG_FILE

echo_subsection "Installing XGBoost Python 2 packages"
AUR_PKG_FILE=$(ls ~/.aur/xgboost-git.git/python2-*.tar.xz)
sudopw pacman -U --needed --noconfirm --color auto $AUR_PKG_FILE
