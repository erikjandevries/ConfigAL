echo_section "Installing Atom"

if [[ "x$(pacman -Qs atom)" == "x" ]]; then
  install_pkg atom

  apm install atom-alignment
  apm install atomatigit
  apm install language-lua
  apm install language-matlab
  apm install language-r
  apm install merge-conflicts
  apm install split-diff

  apm upgrade --no-confirm
else
  echo_info "Atom has already been installed"
fi
