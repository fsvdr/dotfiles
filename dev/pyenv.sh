#!/usr/bin/env bash
###############################################################################
# PYTHON INSTALL                                                              #
###############################################################################

PYENVLATEST="3.7.2"
PYENVPREFIX=${PYENVLATEST:0:3} # Gives us major.minor

do-install-python () {
  info-status "Installing Python $PYENVLATEST vía pyenv"
  if type pyenv 1>/dev/null 2>&1; then
    # Check if the latest version is already installed
    if pyenv which "python$PYENVPREFIX" 1>/dev/null 2>&1; then
      warning-status "Python $PYENVLATEST is already installed!"
    else
      if pyenv install "$PYENVLATEST" 2>/dev/null; then
        pyenv global "$PYENVLATEST"
        success-status "Done"
      else
        error-status "Could not install python :("
      fi
    fi
  else
    error-status "pyenv is not installed!"
  fi
}
