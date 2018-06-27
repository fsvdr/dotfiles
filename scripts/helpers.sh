#!/usr/bin/env bash
# Utilities globally accessible

# Displays some formatted informative message
info-status () {
  printf "\r[ \033[00;34m..\033[0m ] $1\n"
}

# Displays some formatted warning message
warning-status () {
  printf "\r[ \033[0;33m!!\033[0m ] $1\n"
}

# Displays some formatted success message
success-status () {
  printf "\r\033[2K[ \033[00;32mOK\033[0m ] $1\n"
}

# Displays some formatted error message and exits the program
error-status () {
  printf "\r\033[2K[\033[0;31mFAIL\033[0m] $1\n"
}

# Require confirmation from the user
#
# @param  message [$1]
request-confirmation () {
  read -p "$1 [Y/n] " -n 1 -r
  echo
}
