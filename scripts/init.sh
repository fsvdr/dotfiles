#!/usr/bin/env bash
##########################################
# INIT.SH
##########################################
# Get the dotfiles to where they belong
# and initialice the system scaffolding

# Make sure to terminate if something goes wrong
set -e

DOTFILES_ROOT=$(pwd -P)
DOTFILES_ROOT_OLD="$HOME/.dotfiles_old"
FILES=(
  gitconfig
  gitconfig_local
  gitignore_global
)

# Let's buckle up ourselves with some utilities
source "$DOTFILES_ROOT/scripts/helpers.sh"

# Import git configuration script
source "$DOTFILES_ROOT/scripts/git.sh"

# Import symlink script
source "$DOTFILES_ROOT/scripts/symlink.sh"

# Import backup script
source "$DOTFILES_ROOT/scripts/backup.sh"

# Import macos script
source "$DOTFILES_ROOT/scripts/macos.sh"

# Import hombrew scripts
source "$DOTFILES_ROOT/homebrew/install.sh"

echo ""
echo "**********************************************************************"
echo "Dotfiles initialization script"
echo "**********************************************************************"
echo ""
echo "Hello there! Let's get started with your dotfiles. This script will"
echo "guide you through the setup process. The following operations will"
echo "run sequentially:"
echo ""
echo "[1] Backup for pre-existing dotfiles"
echo "[2] Git configuration setup"
echo "[3] Dotfiles linking"
echo "[4] macOS system configuration"
echo ""

backup_old_dotfiles
configure_git
symlink
macos
install_apps

echo ""
echo "Awesome! You're done, go grab a cup of coffee!"
kill_apps
