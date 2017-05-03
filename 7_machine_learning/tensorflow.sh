echo_section "Install Bazel"
gpg --recv-keys 48457EE0
install_pkg_aur bazel


echo_section "Install Wheel"
sudo pip install wheel

echo_section "Clone TensorFlow repository"
ensure_git_clone https://github.com/tensorflow/tensorflow $REPOS_FOLDER/Clones/tensorflow

CURRENT_DIR=$(pwd)
cd $REPOS_FOLDER/Clones/tensorflow

./configure
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package

bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

WHL_PKG_FILE=$(ls /tmp/tensorflow_pkg/tensorflow*.whl)
sudo pip install ${WHL_PKG_FILE}

cd $CURRENT_DIR
