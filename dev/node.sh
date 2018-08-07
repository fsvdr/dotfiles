#!/usr/bin/env bash
###############################################################################
# NODE INSTALL                                                                #
###############################################################################

bootstrap-nvm () {
  info-status "Installing nvm"

  # Weird... couldn't get type, command nor -d to work here
  # don't know why
  if [ $NVM_DIR ]; then
    info-status "nvm is already installed!"

    request-confirmation "Do you want me to install NodeJS via nvm?"
    if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" = "" ]]; then
      do-install-node
    fi
  else
    if curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash 2>/dev/null; then
      success-status "Done"
      do-install-node
    else
      error-status "Could not install nvm :("
    fi
  fi
}

do-install-node () {
  info-status "Installing NodeJS via nvm"

  # Use nvm without reloading
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

  # Weird... nvm install won't work here with set -e (don't know why)
  # so we need to reverse it
  set +e

  # Install both, most current and long term support versions
  if nvm install --lts && nvm install node 2>/dev/null; then
    success-status "Done"
  else
    error-status "Could not install NodeJS. You can try to do it later by typing"
    echo "  nvm install node"
  fi

  # Set it back to -e
  set -e
}
