#!/usr/bin/env bash
###############################################################################
# DEV ENVIRONMENT SCRIPT                                                      #
###############################################################################
# This script installs a few tools for development

bootstrap_dev () {
  echo ""

  info-status "Installing Homebrew"
  if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>/dev/null; then
    success-status "Done"
    install_python
  else
    error-status "Could not install Homebrew. Skipping..."
  fi

  echo ""

  info-status "Installing nvm"
  if curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash 2>/dev/null; then
    success-status "Done"
    install_node
  else
    error-status "Could not install nvm. Skipping..."
  fi

  if type brew; then
    info-status "Installing yarn"
    if brew install yarn --without-node 2>/dev/null; then
      success-status "Done"
    else
      error-status "Could not install yarn. Skipping..."
    fi
  else
    error-status "Hombrew is required to install yarn. Skipping..."
  fi
}

install_python () {
  info-status "Installing pyenv"

  if brew install pyenv; then
    success-status "Done"
  else
    error-status "Could not install pyenv. Skipping..."
  fi
}

install_node () {
  info-status "Installing NodeJS"

  # Use nvm without reloading
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

  # Weird... nvm install won't work here with set -e (don't know why)
  # so we need to reverse it
  set +e

  # Install both, most current and long term support versions
  if nvm install node && nvm install --lts 2>/dev/null; then
    success-status "Done"
  else
    error-status "Could not install NodeJS. You can try to do it later by typing"
    echo "  nvm install node"
  fi

  # Set it back to -e
  set -e
}
