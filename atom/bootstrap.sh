#!/usr/bin/env bash
###############################################################################
# ATOM                                                                        #
###############################################################################
# Let's get atom packages and configuration up and running

# Install atom packages from source file at ~/.dotfiles/atom/packages.txt
bootstrap_atom () {
  # Check for atom package manager
  if type apm >/dev/null 2>&1; then
    display_info "Installing atom packages..."
    apm install --packages-file "$DOTFILES_ROOT/atom/packages.txt"
    display_success "Done"
  else
    display_error "apm is not installed. Skipping..."
  fi
}

# Backup current installed packages at ~/.dotfiles/atom/packages.txt
safeguard_atom () {
  if type apm >/dev/null 2>&1; then
    # Save all installed packages to ./packages.txt
    display_info "Creating atom packages backup..."
    apm list --installed --bare >"$DOTFILES_ROOT/atom/packages.txt"
    display_success "Done. Remember to push in order to persist changes"
  else
    display_error "apm is not installed. Skipping..."
  fi
}
