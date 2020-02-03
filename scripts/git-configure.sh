#!/usr/bin/env bash

: '
  Configure global Git user credentials
'
git-configure() {
  if [[ -f "${0%/*}/dots/gitconfig_local.symlink" ]]; then
    if ! confirm "Git credentials have been configured, override?"; then
      return 0
    fi
  fi

  read -r -p "[User Name]: " git_username
  read -r -p "[User Email]: " git_email
  echo ""

  if ! confirm "Confirm?"; then
    (echo $__clean_pg && git-configure)
  fi

  # Here we write gitconfig_local using gitconfig_local.example as a
  # template and replacing the users credentials with the ones
  # provided
  sed -e "s/<USERNAME>/$git_username/g" -e "s/<EMAIL>/$git_email/g" "dots/gitconfig_local.symlink.example" > "dots/gitconfig_local.symlink"
}
