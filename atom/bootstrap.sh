#!/usr/bin/env bash
###############################################################################
# ATOM                                                                        #
###############################################################################
# Let's get atom packages and configuration up and running

# Install atom packages from source file at ~/.dotfiles/atom/packages.txt
bootstrap-atom () {
  # Check for atom package manager
  if type apm >/dev/null 2>&1; then
    info-status "Installing atom packages..."
    apm install --packages-file "$DOTFILES_ROOT/atom/packages.txt"
    success-status "Done"
  else
    error-status "apm is not installed. Skipping..."
  fi
}

# Backup current installed packages at ~/.dotfiles/atom/packages.txt
safeguard-atom () {
  if type apm >/dev/null 2>&1; then
    # Save all installed packages to ./packages.txt
    info-status "Creating atom packages backup..."
    apm list --installed --bare >"$DOTFILES_ROOT/atom/packages.txt"
    success-status "Done. Remember to push in order to persist changes"
  else
    error-status "apm is not installed. Skipping..."
  fi
}
