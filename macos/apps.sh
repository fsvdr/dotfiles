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
    497799835  # Xcode
    585829637  # Todoist
    409789998  # Twitter
    931134707  # Wire
    747648890  # Telegram
    441258766  # Magnet
    425424353  # The Unarchiver
    525742250  # JPEGmini
    824171161  # Affinity Designer
    408981434  # iMovie
    957734279  # Toggl Desktop
  )

  for app in "${APPS[@]}"; do
    mas install "$app"
  done
}

do-install-cask () {
  APPS=(
    tunnelblick
    staruml
    skyfonts
    abstract
    sketch
    sketch-toolbox
    coda
    atom
    signal
    firefox
    spotify
    xampp
    postgres
    insomnia
    google-chrome
    visual-studio-code
    tableplus
    mongodb-compass
    1password
    google-backup-and-sync
    craftmanager
  )

  for app in "${APPS[@]}"; do
    brew cask install "$app"
  done
}
