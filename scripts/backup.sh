#!/usr/bin/env bash
##########################################
# BACKUP.SH
##########################################
# Backup every pre-existing dotfile in
# the user's HOME

backup_old_dotfiles () {
  display_info "Creating a backup for pre-existing dotfiles..."

  # Create backup directory
  mkdir -p "$DOTFILES_ROOT_OLD"

  # Here we'll move every file or directory that would be overriden
  # by the symlinking step
  for src in $( find -H "$DOTFILES_ROOT" -maxdepth 2 -name "*.symlink" -not -path '*.git*' ); do
    overridable="$HOME/.$(basename "${src%.*}")"
    if cp -RL "$overridable" "$DOTFILES_ROOT_OLD/" 2>/dev/null; then
      rm "$overridable"  "Moved [$src] to ~/$DOTFILES_ROOT_OLD"
    fi
  done

  display_success "Backup completed"
}
