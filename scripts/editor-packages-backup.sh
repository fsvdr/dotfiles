#!/usr/bin/env bash

: '
  Outputs all installed Atom packages to atom-packages.txt
'
atom-packages-backup() {
  type apm &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 Atom Package Manager is not installed"
    return 1
  fi

  apm list --installed --bare > "${0%/*}/atom-packages.txt"
}

: '
  Outputs all installed VS Code extensions to vscode-extensions.txt
  and updates the settings symlink
'
vscode-backup() {
  type code &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 VSCode CLI is not installed"
    return 1
  fi

  code --list-extensions > "${0%/*}/vscode-extensions.txt"

  if [[ ! -e "$HOME/Library/Application Support/Code/User/settings.json" ]]; then
    return 1
  fi

  cat "$HOME/Library/Application Support/Code/User/settings.json" > "${0%/*}/dots/vscode.symlink/settings.json"
}
