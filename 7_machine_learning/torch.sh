echo_section "Installing Torch7"

# install_pkg_aur torch7-cwrap-git
# install_pkg_aur torch7-paths-git
# install_pkg_aur torch7-git
#
#
# echo_subsection "Installing neural networks package for Torch7"
# install_pkg_aur torch7-nn-git
#
# echo_subsection "Installing loadcaffe"
# install_pkg_aur loadcaffe-git


git clone https://github.com/torch/distro.git ~/torch --recursive
# cd ~/torch; bash install-deps;
. ~/torch/install.sh

source ~/.bashrc

luarocks install dpnn
luarocks install nn
luarocks install optim
luarocks install optnet
luarocks install csvigo
luarocks install cutorch
luarocks install cunn
luarocks install fblualib
luarocks install torchx
luarocks install tds
