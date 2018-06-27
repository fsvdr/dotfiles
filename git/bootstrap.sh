#!/usr/bin/env bash
###############################################################################
# GIT BOOTSTRAP SCRIPT                                                        #
###############################################################################
# This script takes care of configuring git credentials and then symlinking
# git dotfiles

bootstrap_git () {
  echo ""

  if [ -f git/gitconfig_local.symlink ]; then
    warning-status "Dotfile [gitconfig] is already configured."
    read -p "   Do you want to override it? [y/n] " confirm

    if [ $confirm == "y" ]; then
      configure_locals
    fi
  else
    configure_locals
  fi

  success-status "Git dotfiles are ready"
}

configure_locals () {
  PROCEED=0

  info-status "Initializing Git Configuration..."
  while [ $PROCEED -eq 0 ]; do
    echo ""

    read -p "   [User Name]: " git_username
    read -p "   [User Email]: " git_email
    echo ""

    read -p "   Confirm? [y/n] " confirm

    if [ "$confirm" = "y" ]; then
      PROCEED=1

      # Here we write gitconfig_local using gitconfig_local.example as a
      # template and replacing the users credentials with the ones
      # provided
      sed -e "s/<USERNAME>/$git_username/g" -e "s/<EMAIL>/$git_email/g" "git/gitconfig_local.symlink.example" > "git/gitconfig_local.symlink"
    fi
  done
}
