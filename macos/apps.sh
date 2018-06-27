#!/usr/bin/env bash
###############################################################################
# APPS!                                                                       #
###############################################################################

bootstrap_apps () {
  # Let's install mas, a command line interface for the Mac App Store
  # https://github.com/mas-cli/mas

  # Check for hombrew before installing
  if type brew >/dev/null 2>&1; then
    info-status "Installing mac app store cli (mas)"

    # Install apps from the mac app store
    if brew install mas 2>/dev/null; then
      success-status "Done"
      do_install_mas
    else
      error-status "Could not install mas. Skipping mac app store apps..."
    fi

    info-status "Installing hombrew-cask"

    # Install apps using cask
    if brew tap homebrew/cask 2>/dev/null; then
      brew tap caskroom/cask
      success-status "Done"
      do_install_cask

      success-status "Apps successfully installed!"
    else
      error-status "Could not install cask. Skipping hombrew-cask apps..."
    fi

  else
    error-status "Hombrew is required to install the apps! Try:"
    echo "  dotfiles dev"
  fi
}

do_install_mas () {
  APPS=(
    497799835  # Xcode
    585829637  # Todoist
    409789998  # Twitter
    931134707  # Wire
    747648890  # Telegram
    441258766  # Magnet
    425424353  # The Unarchiver
    525742250  # JPEGmini
  )

  for app in "${APPS[@]}"; do
    mas install "$app"
  done
}

do_install_cask () {
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
