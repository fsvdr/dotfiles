#!/usr/bin/env bash

git-configure() {
  if [[ -f "${0%/*}/git/gitconfig_local.symlink" ]]; then
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

  sed -e "s/<USERNAME>/$git_username/g" -e "s/<EMAIL>/$git_email/g" "git/gitconfig_local.symlink.example" > "git/gitconfig_local.symlink"
}
