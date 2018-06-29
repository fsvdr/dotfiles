#!/usr/bin/env bash
###############################################################################
# SYSTEM UPDATE                                                               #
###############################################################################

do-update () {
  info-status "Updating App Sotre apps"
  sudo softwareupdate -i -a
  success-status "Done"

  if type brew >/dev/null 2>&1; then
    info-status "Updating Hombrew and packages"
    brew update
    brew upgrade
    success-status "Done"
  fi

  if type npm >/dev/null 2>&1; then
    info-status "Updating npm and packages"
    npm install npm -g
    npm update -g
    success-status "Done"
  fi
}

do-clean () {
  if type brew >/dev/null 2>&1; then
    info-status "Clearing brew cache"
    brew cleanup
    brew cask cleanup
    success-status "Done"
  fi

  if type npm >/dev/null 2>&1; then
    info-status "Clearing npm cache"
    npm cache clean
    gem cleanup
    success-stats "Done"
  fi
}

do-edit () {
  $EDITOR $DOTFILES_ROOT
}

do-disengage () {

  safeguard-atom

  mkdir -p "$DOTFILES_ROOT/lifeguard-kit"

  if [[ -d "$HOME/.ssh" ]]; then
    info-status "Packing up SSH keys... you're welcome"
    if mv "$HOME/.ssh" "$DOTFILES_ROOT/lifeguard-kit" >/dev/null 2>&1; then
      success-status "Done"
    else
      error-status "Whooops, something went wrong there"
    fi
  fi

  info-status "Packing up Skrifa secure backup"
  warning-status "Could you please create a Skrifa backup and put it in Desktop for me?"
  request-confirmation "Did you do it?"
  if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" = "" ]]; then
    echo "Thanks, I can handle from here on"
    if mv "$HOME/Desktop/*.skb" "$DOTFILES_ROOT/lifeguard-kit" >/dev/null 2>&1; then
      success-status "Done"
    else
      error-status "Whooops, something went wrong there"
    fi
  else
    error-status "Cool man, skipping..."
  fi

  # Create encrypted disk image of the lifeguard kit
  # Thanks to The Instructional for this one [http://www.theinstructional.com/guides/disk-management-from-the-command-line-part-3]

  info-status "Creating encrypted lifeguard kit..."
  echo ""
  echo "*********************************************************************"
  echo "🤖  Sorry for the interruption, I just needed to take a sec to remind"
  echo "you just how important it is that you pay attention to this"
  echo "Don't come blaming me if you f*** it up. You just have to follow"
  echo "these two (2) simple steps:"
  echo "*********************************************************************"
  echo "1. Don't forget the password"
  echo "2. Don't forget to put the kit on a USB or some cloud"
  echo ""
  echo "Thanks. You can do this. I believe in you. Don't let me down."
  echo ""

  if hdiutil create "$HOME/Desktop/lifeguard-kit.dmg" -encryption -volname "Lifeguard Kit" -srcfolder "$DOTFILES_ROOT/lifeguard-kit"; then
    success-status "Your lifeguard kit is ready and waiting for you in Desktop"
  fi

  echo ""
  warning-status "Now it's a good time to push changes to this repo!"
}
