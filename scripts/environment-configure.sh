#!/usr/bin/env bash

: '
  Installs the development environment dependencies through Volta.sh and Homebrew
'
environment-configure() {
  type volta &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  ⏬ Installing Volta\n"
    curl https://get.volta.sh | bash
  fi

  echo -ne "\n  ⏬ Installing Volta toolkit\n"
  volta install {"node","yarn","bash-language-server","parcel-bundler","gatsby-cli"}

  type brew &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "\n  ⏬ Installing Homebrew\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo -ne "\n  ⏬ Installing Homebrew dependencies\n"
  brew install {"git-lfs","mas","php","python3","httpie","youtube-dl"}

  return 0
}
