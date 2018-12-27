#!/usr/bin/env bash
###############################################################################
# APPS!                                                                       #
###############################################################################

bootstrap-apps () {
  # Let's install mas, a command line interface for the Mac App Store
  # https://github.com/mas-cli/mas

  # Check for hombrew before installing
  if type brew >/dev/null 2>&1; then

    # Install apps from the mac app store
    if type mas 1>/dev/null 2>&1; then
      info-status "Installing mac app store apps"
      do-install-mas
    else
      error-status "mas is not installed! Skipping mac app store apps"
    fi

    info-status "Installing hombrew-cask"
    # Install apps using cask
    if brew tap homebrew/cask 2>/dev/null; then
      brew tap caskroom/cask
      success-status "Done"
      do-install-cask

      success-status "Apps successfully installed!"
    else
      error-status "Could not install cask. Skipping hombrew-cask apps..."
    fi

  else
    error-status "Hombrew is required to install the apps! Try:"
    echo "  dotfiles dev"
  fi
}

do-install-mas () {
  APPS=(
    824171161  # Affinity Designer
    408981434  # iMovie
    525742250  # JPEGmini
    441258766  # Magnet
    747648890  # Telegram
    425424353  # The Unarchiver
    585829637  # Todoist
    409789998  # Twitter
    931134707  # Wire
    497799835  # Xcode
  )

  for app in "${APPS[@]}"; do
    mas install "$app"
  done
}

do-install-cask () {
  APPS=(
    # Dev
    atom
    android-studio
    coda
    insomnia
    mongodb-compass
    staruml
    postgres
    tableplus
    visual-studio-code
    xampp-vm

    # Design
    abstract
    craftmanager
    rightfont
    sketch

    # Entretainment
    pocket-casts
    spotify

    # Everything else
    1password
    firefox
    google-chrome
    signal
    tunnelblick
    protonvpn
  )

  for app in "${APPS[@]}"; do
    brew cask install "$app"
  done
}
