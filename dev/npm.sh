#!/usr/bin/env bash
###############################################################################
# NPM PACKAGES                                                                #
###############################################################################

do-install-npm-deps () {
  PACKAGES=(
    "bash-language-server"
    "create-react-app"
    "create-react-native-app"
    "parcel"
    "@angular/cli"
  )

  info-status "Installing npm global dependency packages"

  if type npm 1>/dev/null 2>&1; then
    for dep in "${PACKAGES[@]}"; do
      npm -g install "$dep"
    done

    success-status "Done"
  else
    error-status "npm is not installed!"
  fi
}
