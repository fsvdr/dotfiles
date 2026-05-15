#!/usr/bin/env bash

: '
  Creates symbolic links to every *.symlink file inside the dots directory.

  Naming convention:
    foo.symlink              -> ~/.foo
    foo+bar+baz.symlink      -> ~/.foo/bar/baz       ("+" separates path segments)
    +foo+bar.symlink         -> ~/foo/bar            (leading "+" means no dot prefix,
                                                      for paths like ~/Library/...)
    Parent directories are created as needed.
'
dotfiles-symlink() {
  for src in $(find -H "$HOME/.dotfiles/dots" -name "*.symlink"); do
    local name="$(basename "${src%.symlink}")"
    local dst
    if [[ "$name" == +* ]]; then
      dst="$HOME/${name#+}"
    else
      dst="$HOME/.$name"
    fi
    dst="${dst//+//}"
    mkdir -p "$(dirname "$dst")"
    ln -sfv "$src" "$dst" 2>/dev/null >&2
  done
}
