#!/usr/bin/env bash

: '
  Installs Atom packages listed on atom-packages.txt
'
atom-configure() {
  type apm &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 Atom Package Manager is not installed"
    return 1
  fi

  apm install --packages-file "${0%/*}/atom-packages.txt"
}

: '
  Installs VSCode extensions listed on vscode-extensions.txt
'
vscode-configure() {
  type code &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 VSCode CLI is not installed"
    return 1
  fi

  cat "${0%/*}/vscode-extensions.txt" | while read extension; do
    code --install-extension "$extension"
  done
}
