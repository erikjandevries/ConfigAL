echo_section "Installing dlib"

# install_pkg_aur dlib
# install_pkg_aur python-dlib

ensure_git_clone https://github.com/davisking/dlib.git $REPOS_FOLDER/Clones/dlib

CURRENT_DIR=$(pwd)
cd $REPOS_FOLDER/Clones/dlib

# mkdir build; cd build; cmake .. -DUSE_AVX_INSTRUCTIONS=1; cmake --build .
mkdir build; cd build; cmake .. -DUSE_AVX_INSTRUCTIONS=1; cmake --build . --config Release
cd ..
sudo python3 setup.py install --yes USE_AVX_INSTRUCTIONS

cd $CURRENT_DIR
