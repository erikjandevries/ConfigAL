echo_section "Installing Atom"

ensure_pkg atom

apm_ensure_pkg atom-alignment
apm_ensure_pkg atomatigit
apm_ensure_pkg language-lua
apm_ensure_pkg language-matlab
apm_ensure_pkg language-r
apm_ensure_pkg merge-conflicts
apm_ensure_pkg split-diff

apm upgrade --no-confirm
