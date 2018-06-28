#!/usr/bin/env bash
###############################################################################
# DEV ENVIRONMENT SCRIPT                                                      #
###############################################################################
# This script installs a few tools for development

source "$DOTFILES_ROOT/dev/brew.sh"
source "$DOTFILES_ROOT/dev/node.sh"
source "$DOTFILES_ROOT/dev/npm.sh"
source "$DOTFILES_ROOT/dev/pyenv.sh"

bootstrap-dev () {
  bootstrap-brew
  bootstrap-nvm

  request-confirmation "Do you want me to install npm packages?"
  if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" = "" ]]; then
    do-install-npm-deps
  fi
  
  do-install-python

  echo ""
  success-status "Done"
}
