#!/usr/bin/env bash
###############################################################################
# SYSTEM UPDATE                                                               #
###############################################################################

do-update () {
  info-status "Updating App Sotre apps"
  sudo softwareupdate -i -a
  success-status "Done"

  if type brew >/dev/null 2>&1; then
    info-status "Updating Hombrew and packages"
    brew update
    brew upgrade
    success-status "Done"
  fi

  if type npm >/dev/null 2>&1; then
    info-status "Updating npm and packages"
    npm install npm -g
    npm update -g
    success-status "Done"
  fi
}

do-clean () {
  if type brew >/dev/null 2>&1; then
    info-status "Clearing brew cache"
    brew cleanup
    brew cask cleanup
    success-status "Done"
  fi

  if type npm >/dev/null 2>&1; then
    info-status "Clearing npm cache"
    npm cache clean
    gem cleanup
    success-stats "Done"
  fi
}

do-edit () {
  $EDITOR $DOTFILES_ROOT
}
