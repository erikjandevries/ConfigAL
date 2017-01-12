echo_section "Installing VLC media player (incl. web interface)"

echo_subsection "Installing VLC"
ensure_pkg vlc

echo_subsection "Setting up web interface"
echo_info "Creating user account"
sudopw useradd -c "VLC daemon" -d / -G audio -M -p \! -r -s /bin/false -u 75 -U vlcd

echo_info "Creating service config file"
sudo tee /etc/systemd/system/vlc.service << EOF > /dev/null
[Unit]
Description=VideoOnLAN Service
After=network.target

[Service]
Type=forking
User=vlcd
ExecStart=/usr/bin/vlc --daemon --syslog -I http --http-port ${VLC_HTTP_PORT} --http-password ${VLC_HTTP_PASSWORD}
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

echo_info "Starting and enabling VLC service"
sudopw systemctl enable vlc.service
sudopw systemctl start vlc.service
