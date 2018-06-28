#!/usr/bin/env bash
###############################################################################
# HOMBREW INSTALL                                                             #
###############################################################################

PACKAGES=(
  "mas"
  "pyenv"
  "yarn"
  "mongodb"
)

bootstrap-brew () {
  info-status "Installing Homebrew"

  if type brew &>/dev/null 2>&1; then
    warning-status "Hombrew is already installed!"

    request-confirmation "Do you want me to install dependencies via brew?"
    if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" = "" ]]; then
      do-install-packages
    fi
  else
    if /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 2>/dev/null; then
      success-status "Done"
      do-install-packages
    else
      error-status "Could not install Hombrew :("
    fi
  fi
}

do-install-packages () {
  for dep in "${PACKAGES[@]}"; do
    brew install "$dep"
  done

  success-status "Done"
}
