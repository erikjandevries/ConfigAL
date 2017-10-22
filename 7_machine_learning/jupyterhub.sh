echo_section "Installing JupyterHub"

ensure_pkg nodejs npm

sudopw pip install --upgrade jupyterhub
sudopw npm install -g configurable-http-proxy
sudopw pip install --upgrade notebook
