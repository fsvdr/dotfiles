#!/usr/bin/env bash

: '
  Installs the development environment dependencies through mise and Homebrew
'
environment-configure() {
  # Homebrew
  type brew &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "\n  ⏬ Installing Homebrew\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo -ne "\n  ⏬ Installing Homebrew dependencies\n"
  brew install git-lfs mas httpie

  # Oh My Zsh
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo -ne "\n  ⏬ Installing Oh My Zsh\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  # Zsh plugins
  local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    echo -ne "\n  ⏬ Installing zsh-autosuggestions\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi

  if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    echo -ne "\n  ⏬ Installing zsh-syntax-highlighting\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi

  # mise (version manager for Node, Python, etc.)
  type mise &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "\n  ⏬ Installing mise\n"
    brew install mise
  fi

  # Fonts
  echo -ne "\n  ⏬ Installing fonts\n"
  brew install font-fira-code

  return 0
}
