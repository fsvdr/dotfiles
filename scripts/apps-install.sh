#!/usr/bin/env bash

: '
  Install user defined applications via the Mac App Store command line interface and Homebrew Cask
'
apps-install() {
  local mas_apps=(
    824171161  # Affinity Designer
    1091189122 # Bear
    1451177988 # Carbonize
    408981434  # iMovie
    525742250  # JPEGmini
    441258766  # Magnet
    803453959  # Slack
    747648890  # Telegram
    425424353  # The Unarchiver
    585829637  # Todoist
    497799835  # Xcode
  )

  local cask_apps=(
    # Dev
    atom
    android-studio
    fork
    insomnia
    mongodb-compass
    postgres
    tableplus
    vagrant
    virtualbox
    visual-studio-code
    xampp-vm

    # Design
    craftmanager
    rightfont
    sketch
    figma

    # Entretainment
    pocket-casts
    spotify

    # Everything else
    1password
    firefox
    firefox-developer-edition
    google-chrome
    imageoptim
    keybase
    signal
    tunnelblick
  )

  type mas &>/dev/null
  if [[ $? -eq 1 ]]; then
    brew install mas
  fi

  echo -ne "\n  ⏬ Installing Mac App Store apps\n"
  for app in "${mas_apps[@]}"; do
    mas install "$app"
  done

  echo -ne "\n  ⏬ Installing Cask apps\n"
  for app in "${cask_apps[@]}"; do
    brew cask install "$app"
  done
}
