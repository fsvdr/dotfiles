#!/usr/bin/env bash
###############################################################################
# DEV ENVIRONMENT SCRIPT                                                      #
###############################################################################
# This script installs a few tools for development

bootstrap_dev () {
  echo ""

  display_info "Installing Homebrew"
  if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>/dev/null; then
    display_success "Done"
    install_python
  else
    display_error "Could not install Homebrew. Skipping..."
  fi

  echo ""

  display_info "Installing nvm"
  if curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash 2>/dev/null; then
    display_success "Done"
    install_node
  else
    display_error "Could not install nvm. Skipping..."
  fi

  if type brew; then
    display_info "Installing yarn"
    if brew install yarn --without-node 2>/dev/null; then
      display_success "Done"
    else
      display_error "Could not install yarn. Skipping..."
    fi
  else
    display_error "Hombrew is required to install yarn. Skipping..."
  fi
}

install_python () {
  display_info "Installing pyenv"

  if brew install pyenv; then
    display_success "Done"
  else
    display_error "Could not install pyenv. Skipping..."
  fi
}

install_node () {
  display_info "Installing NodeJS"

  # Use nvm without reloading
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

  # Weird... nvm install won't work here with set -e (don't know why)
  # so we need to reverse it
  set +e

  # Install both, most current and long term support versions
  if nvm install node && nvm install --lts 2>/dev/null; then
    display_success "Done"
  else
    display_error "Could not install NodeJS. You can try to do it later by typing"
    echo "  nvm install node"
  fi

  # Set it back to -e
  set -e
}
