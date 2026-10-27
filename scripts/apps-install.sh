#!/usr/bin/env bash

: '
  Install user defined applications via the Mac App Store command line interface and Homebrew Cask
'
apps-install() {
  local mas_apps=(
    441258766  # Magnet
    803453959  # Slack
    747648890  # Telegram
    425424353  # The Unarchiver
    497799835  # Xcode
    1502839586 # Hand Mirror
  )

  local cask_apps=(
    # Dev
    claude
    fork
    insomnia
    postgres
    t3-code
    tableplus
    tailscale-app
    sf-symbols
    warp
    whatsapp
    zed

    # Design
    figma

    # Entertainment
    spotify

    # Everything else
    1password
    bambu-studio
    firefox
    firefox-developer-edition
    google-chrome
    imageoptim
    mole-app
    protonvpn
    raycast
    signal
    zoom
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
    brew install "$app"
  done
}
