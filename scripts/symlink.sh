#!/usr/bin/env bash
##########################################
# SYMLINK.SH
##########################################
# Create symlinks for the dotfiles

do-symlink () {
  echo ""
  info-status "Linking dotfiles to home directory"

  for src in $( find -H "$DOTFILES_ROOT" -maxdepth 2 -name "*.symlink" -not -path '*.git*' ); do
    dst="$HOME/.$(basename "${src%.*}")"
    ln -sfv $src $dst 2>/dev/null >&2 && info-status "Linked $dst to $src"
  done

  success-status "Dotfiles successfully linked"
}
