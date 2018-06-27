#!/usr/bin/env bash
###############################################################################
# BACKUP BOOTSTRAP SCRIPT                                                     #
###############################################################################
# This script takes care of performing a backup for pre-existing dotfiles
# in the system

BACKUPEXCLUDES=(
  atom                    # To heavy
  git-completion.bash     # This one doesn't change
  git-prompt.sh           # Neither does this one
)

do_backup () {
  DOTFILES_ROOT_OLD="$HOME/.dotfiles_old"
  info-status "Creating a backup for pre-existing dotfiles..."

  # Create backup directory
  mkdir -p "$DOTFILES_ROOT_OLD"

  # Here we'll move every file or directory that would be overriden
  # by the symlinking step
  for src in $( find -H "$DOTFILES_ROOT" -maxdepth 2 -name "*.symlink" -not -path "*.git*"  ); do
    name=$(basename "${src%.*}")
    # Check for file/directory that should not be backed up
    if [[ "${BACKUPEXCLUDES[@]}" != *"$name"* ]]; then
      overridable="$HOME/.$name"
      if cp -RL "$overridable" "$DOTFILES_ROOT_OLD/" 2>/dev/null; then
        rm "$overridable" && info-status "Moved [$src] to ~/$DOTFILES_ROOT_OLD"
      fi
    fi
  done

  success-status "Backup completed"
}
