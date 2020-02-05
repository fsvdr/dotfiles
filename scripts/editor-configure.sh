#!/usr/bin/env bash

: '
  Installs Atom packages listed on atom-packages.txt
'
editor-configure() {
  type apm &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 Atom Package Manager is not installed"
    return 1
  fi

  apm install --packages-file "${0%/*}/atom-packages.txt"
}
