#!/usr/bin/env bash

: '
  Creates symbolic links to every *.symlink file inside the dots directory
'
dotfiles-symlink() {
  for src in $(find -H "${0%/*}/dots" -name "*.symlink"); do
    local dst="$HOME/.$(basename "${src%.*}")"
    ln -sfv $src $dst 2>/dev/null >&2
  done
}
