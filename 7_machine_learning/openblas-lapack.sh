echo_section "Installing OpenBLAS and LAPACK"

# Change USE_OPENMP=0 to USE_OPENMP=1 in PKGBUILD file!!
# install_pkg_aur openblas-lapack

ensure_dir ~/.aur
ensure_git_clone https://aur.archlinux.org/openblas-lapack.git ~/.aur/openblas-lapack.git

CURRENT_DIR=$(pwd)
cd ~/.aur/openblas-lapack.git

# Change USE_OPENMP=0 to USE_OPENMP=1 in PKGBUILD file!!
replace_conf "_config=\"FC=gfortran USE_OPENMP=0 USE_THREAD=1 \\" "_config=\"FC=gfortran USE_OPENMP=1 USE_THREAD=1 \\" ~/.aur/openblas-lapack.git/PKGBUILD

makepkg -scf
AUR_PKG_FILE=$(ls $1*.tar.xz)

sudopw pacman -U --needed --noconfirm --color auto ~/.aur/$1.git/$AUR_PKG_FILE
cd $CURRENT_DIR
