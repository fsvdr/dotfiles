#!/usr/bin/env bash

: '
  Outputs all installed Atom packages to atom-packages.txt
'
editor-packages-backup() {
  type apm &>/dev/null
  if [[ $? -eq 1 ]]; then
    echo -ne "  🚨 Atom Package Manager is not installed"
    return 1
  fi

  apm list --installed --bare > "${0%/*}/atom-packages.txt"
}
