echo_section "Installing Git"

ensure_pkg git

if [[ "x$GIT_USER_NAME" == "x" ]]; then
  echo_warn "Git user name not set"
else
  echo_info "Setting Git global user.name: $GIT_USER_NAME"
  git config --global user.name "$GIT_USER_NAME"
fi
if [[ "x$GIT_USER_EMAIL" == "x" ]]; then
  echo_warn "Git user email not set"
else
  echo_info "Setting Git global user.email: $GIT_USER_EMAIL"
  git config --global user.email "$GIT_USER_EMAIL"
fi

git config --global push.default simple
