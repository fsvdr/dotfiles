#!/usr/bin/env bash
###############################################################################
# BACKUP BOOTSTRAP SCRIPT                                                     #
###############################################################################
# This script takes care of performing a backup for pre-existing dotfiles
# in the system

do_backup () {
  DOTFILES_ROOT_OLD="$HOME/.dotfiles_old"
  display_info "Creating a backup for pre-existing dotfiles..."

  # Create backup directory
  mkdir -p "$DOTFILES_ROOT_OLD"

  # Here we'll move every file or directory that would be overriden
  # by the symlinking step
  for src in $( find -H "$DOTFILES_ROOT" -maxdepth 2 -name "*.symlink" -not -path '*.git*' ); do
    overridable="$HOME/.$(basename "${src%.*}")"
    if cp -RL "$overridable" "$DOTFILES_ROOT_OLD/" 2>/dev/null; then
      rm "$overridable" && display_info "Moved [$src] to ~/$DOTFILES_ROOT_OLD"
    fi
  done

  display_success "Backup completed"
}
