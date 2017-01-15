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
