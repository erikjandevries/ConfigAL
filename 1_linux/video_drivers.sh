echo_section "Installing video drivers"

if [[ $(lspci -k | grep -E "(VGA|3D)") == *"NVIDIA"* ]]; then
  echo_subsection "Installing nVidia drivers"
  ensure_pkg nvidia nvidia-libgl nvidia-settings

  if [[ "${INSTALL_NVIDIA_CUDA}" == "true" ]]; then
    echo_subsection "Installing nVidia CUDA drivers"
    ensure_pkg cuda
  fi
else
  echo_subsection "Installing MESA drivers"
  ensure_pkg mesa
fi
