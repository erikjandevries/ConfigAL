echo_section "Installing Python"

echo_subsection "Installing ${color_green}base development packages${color_yellow}"
ensure_pkg base-devel

echo_subsection "Installing ${color_green}Python${color_yellow}"
ensure_pkg python

echo_subsection "Installing ${color_green}Python setup tools${color_yellow}"
ensure_pkg python-setuptools

echo_subsection "Installing ${color_green}pip${color_yellow}"
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




echo_subsection "Installing ${color_green}Numpy${color_yellow} (linked with OpenBLAS)"
install_pkg_aur python-numpy-openblas
install_pkg_aur python2-numpy-openblas

echo_subsection "Installing ${color_green}SciPy${color_yellow} (linked with OpenBLAS)"
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

echo_subsection "Installing ${color_green}Pandas${color_yellow}"
ensure_pkg python-pandas
ensure_pkg python2-pandas

echo_subsection "Installing ${color_green}Pillow${color_yellow}"
ensure_pkg python-pillow
ensure_pkg python2-pillow

echo_subsection "Installing ${color_green}Matplotlib${color_yellow}"
ensure_pkg python-matplotlib
ensure_pkg python2-matplotlib

echo_subsection "Installing ${color_green}scikit-learn${color_yellow}"
ensure_pkg python-scikit-learn
ensure_pkg python2-scikit-learn




echo_subsection "Installing ${color_green}SymPy${color_yellow}"
ensure_pkg python-sympy
ensure_pkg python2-sympy

echo_subsection "Installing ${color_green}libgpuarray${color_yellow}"
install_pkg_aur libgpuarray-git


echo_subsection "Installing ${color_green}Theano${color_yellow}"
ensure_git_clone https://github.com/Theano/Theano.git $REPOS_FOLDER/Clones/Theano
# pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
sudo pip install --upgrade --no-deps $REPOS_FOLDER/Clones/Theano

echo_info "Configuring Theano to use the GPU"
tee ~/.theanorc << EOF > /dev/null
[global]
floatX = float32
device = gpu0

; To get an error if Theano cannot use cuDNN, use the following flag:
; optimizer_including=cudnn

[nvcc]
fastmath = True
EOF


echo_subsection "Installing ${color_green}Lasagne${color_yellow}"
ensure_git_clone https://github.com/Lasagne/Lasagne $REPOS_FOLDER/Clones/Lasagne
# pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
sudo pip install --upgrade --no-deps $REPOS_FOLDER/Clones/Lasagne

echo_subsection "Installing ${color_green}requests${color_yellow} for downloading files"
# Required for OpenAI Gym
sudo pip install --upgrade requests

echo_subsection "Installing ${color_green}OpenAI Gym${color_yellow}"
ensure_git_clone https://github.com/openai/gym $REPOS_FOLDER/Clones/gym
sudo pip install --upgrade --no-deps -e $REPOS_FOLDER/Clones/gym
