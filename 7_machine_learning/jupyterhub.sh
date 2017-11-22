echo_section "Installing JupyterHub"

ensure_pkg nodejs npm

sudopw pip install --upgrade jupyterhub
sudopw npm install -g configurable-http-proxy
sudopw pip install --upgrade notebook

ensure_dir /etc/jupyterhub -sudo
sudopw jupyterhub --generate-config -f /etc/jupyterhub/jupyterhub_config.py

replace_conf "#c.JupyterHub.ip = ''" "c.JupyterHub.ip = '127.0.0.1'" /etc/jupyterhub/jupyterhub_config.py -sudo

sudopw cp $CONFIGAL_CURRENT/7_machine_learning/files/jupyterhub.service /etc/systemd/system/jupyterhub.service
sudopw systemctl enable jupyterhub.service
sudopw systemctl start jupyterhub.service
