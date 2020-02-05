#!/usr/bin/env bash

: '
  Sets up SSH keys permissions and adds primary identity to Keychain
'
ssh-keys-restore() {
  local __is__done="\n  ✅ Done                \n"

  echo -ne "\n  🔐  Setting up keys permissions\n"
  # .ssh directory (drwx------)
  chmod 700 ~/.ssh

  # Private keys (-rw-------)
  for key in $(ls ~/.ssh); do
    chmod 600 ~/.ssh/$key
  done

  # Public keys (-rw-r--r--)
  for key in $(find -H ~/.ssh -maxdepth 1 -name "*.pub"); do
    chmod 644 "$key"
  done

  if ! [[ -f ~/.ssh/id_rsa ]]; then
    echo $__is__done
    return 0
  fi

  echo -ne "\n  🔑  Adding primary identity to Keychain\n"

  eval "$(ssh-agent -s)" &>/dev/null
  ssh-add -K ~/.ssh/id_rsa

  echo -ne $__is__done
}
