#!/usr/bin/env bash

: '
  Request confirmation from user

  This is a [yY ]/[nN] confirmation, any other response will re-run the confirmation

  @param  message [$1]  The confirmation message to display
'
confirm() {
  read -n 1 -r -p "$1 [y/n] " ANSWER

  if [[ "${ANSWER:-"y"}" =~ ^[yY]$ ]]; then
    echo "" && echo ""
    return 0
  fi

  if [[ "$ANSWER" =~ ^[nN]$ ]]; then
    echo "" && echo ""
    return 1
  fi

  (echo "" && confirm "$1")
}
