echo_section "Setting up the network"

echo_subsection "Installing packages for wireless networking"
ensure_pkg iw wpa_supplicant

if [[ "${INSTALL_NETWORK_MANAGER}" == "true" ]]; then
  echo_subsection "Installing Network Manager"
  ensure_pkg networkmanager

  echo_subsection "Enabling and starting Network Manager"
  sudopw systemctl enable NetworkManager
  sudopw systemctl start NetworkManager
fi

if [[ "${USE_SYSTEMD_NETWORKD}" == "true" ]]; then
  echo_subsection "Setting up wired network"
  sudo tee /etc/systemd/network/wired.network << EOF > /dev/null
[Match]
Name=${NETWORK_WIRED_DEVICE}

[Network]
IPv6PrivacyExtensions=true
EOF

  if [[ "${NETWORK_WIRED_DHCP}" == "true" ]]; then
    echo "DHCP=yes" | sudo tee --append /etc/systemd/network/wired.network
    echo "#Address=${NETWORK_WIRED_FIXED_ADDRESS}" | sudo tee --append /etc/systemd/network/wired.network
    echo "#DNS=${NETWORK_WIRED_FIXED_DNS}" | sudo tee --append /etc/systemd/network/wired.network
    echo "#Gateway=${NETWORK_WIRED_FIXED_GATEWAY}" | sudo tee --append /etc/systemd/network/wired.network
    echo "" | sudo tee --append /etc/systemd/network/wired.network
    echo "[DHCP]" | sudo tee --append /etc/systemd/network/wired.network
    echo "RouteMetric=10" | sudo tee --append /etc/systemd/network/wired.network
  else
    echo "#DHCP=yes" | sudo tee --append /etc/systemd/network/wired.network
    echo "Address=${NETWORK_WIRED_FIXED_ADDRESS}" | sudo tee --append /etc/systemd/network/wired.network
    echo "DNS=${NETWORK_WIRED_FIXED_DNS}" | sudo tee --append /etc/systemd/network/wired.network
    echo "Gateway=${NETWORK_WIRED_FIXED_GATEWAY}" | sudo tee --append /etc/systemd/network/wired.network
    echo "" | sudo tee --append /etc/systemd/network/wired.network
    echo "[Route]" | sudo tee --append /etc/systemd/network/wired.network
    echo "Metric=10" | sudo tee --append /etc/systemd/network/wired.network
  fi


  echo_subsection "Setting up wireless network"

  sudo tee /etc/wpa_supplicant/wpa_supplicant-${NETWORK_WIRELESS_DEVICE}.conf << EOF > /dev/null
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=wheel
update_config=1
eapol_version=1
ap_scan=1
fast_reauth=1
EOF


  sudo tee /etc/systemd/network/wireless.network << EOF > /dev/null
[Match]
Name=${NETWORK_WIRELESS_DEVICE}

[Network]
IPv6PrivacyExtensions=true
EOF

  if [[ "${NETWORK_WIRELESS_DHCP}" == "true" ]]; then
    echo "DHCP=yes" | sudo tee --append /etc/systemd/network/wireless.network
    echo "#Address=${NETWORK_WIRELESS_FIXED_ADDRESS}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "#DNS=${NETWORK_WIRELESS_FIXED_DNS}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "#Gateway=${NETWORK_WIRELESS_FIXED_GATEWAY}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "" | sudo tee --append /etc/systemd/network/wired.network
    echo "[DHCP]" | sudo tee --append /etc/systemd/network/wired.network
    echo "RouteMetric=20" | sudo tee --append /etc/systemd/network/wired.network
  else
    echo "#DHCP=yes" | sudo tee --append /etc/systemd/network/wireless.network
    echo "Address=${NETWORK_WIRELESS_FIXED_ADDRESS}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "DNS=${NETWORK_WIRELESS_FIXED_DNS}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "Gateway=${NETWORK_WIRELESS_FIXED_GATEWAY}" | sudo tee --append /etc/systemd/network/wireless.network
    echo "" | sudo tee --append /etc/systemd/network/wired.network
    echo "[Route]" | sudo tee --append /etc/systemd/network/wired.network
    echo "Metric=20" | sudo tee --append /etc/systemd/network/wired.network
  fi

  echo_subsection "Starting network services"
  sudopw rm /etc/resolv.conf
  sudopw ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

  sudopw systemctl enable systemd-networkd
  sudopw systemctl enable wpa_supplicant@${NETWORK_WIRELESS_DEVICE}
  sudopw systemctl enable systemd-resolved
  sudopw systemctl start systemd-networkd
  sudopw systemctl start wpa_supplicant@${NETWORK_WIRELESS_DEVICE}
  sudopw systemctl start systemd-resolved

  NIC_NAME=$(ip link | grep -m 1 "BROADCAST" | awk -F': ' '{print $2}')
  sudopw systemctl disable dhcpcd@${NIC_NAME}.service

  echo_subsection "Adding WIFI setup to configuration"
  set +o history
  sudo wpa_passphrase ${NETWORK_WIRELESS_ESSID} ${NETWORK_WIRELESS_passphrase} | sudo tee --append /etc/wpa_supplicant/wpa_supplicant-${NETWORK_WIRELESS_DEVICE}.conf
  replace_conf "\t#psk=\"${NETWORK_WIRELESS_passphrase}\"" "" /etc/wpa_supplicant/wpa_supplicant-${NETWORK_WIRELESS_DEVICE}.conf -sudo
  set -o history
fi
