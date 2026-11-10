#!/usr/bin/env bash

: '
  Symlinks Zed settings (and keymap, when tracked) from the dotfiles repo into
  ~/.config/zed. Extensions are installed by Zed itself on launch from the
  `auto_install_extensions` setting in settings.json.
'
zed-configure() {
  local zed_config_dir="$HOME/.config/zed"
  local dotfiles_zed_dir="$HOME/.dotfiles/dots/zed"

  if [[ ! -f "$dotfiles_zed_dir/settings.json" ]]; then
    echo -ne "  ⚠️  $dotfiles_zed_dir/settings.json not found\n"
    return 1
  fi

  mkdir -p "$zed_config_dir"

  local file src dst
  for file in settings.json keymap.json; do
    src="$dotfiles_zed_dir/$file"
    dst="$zed_config_dir/$file"
    [[ -f "$src" ]] || continue

    # Keep whatever Zed (or a previous setup) left there before replacing it
    if [[ -e "$dst" && ! -L "$dst" ]]; then
      mv "$dst" "$dst.bak"
      echo -ne "  💾 Backed up existing $file to $file.bak\n"
    fi

    ln -sfn "$src" "$dst" || return 1
    echo -ne "  🔗 Linked Zed $file\n"
  done

  # Leftover from when the zed folder was named zed.symlink
  if [[ -L "$HOME/.zed" ]]; then
    rm "$HOME/.zed"
    echo -ne "  🧹 Removed stale ~/.zed link\n"
  fi
}

: '
  Settings and keymap are symlinked, so they never need copying back. Lists the
  extensions installed in Zed that are missing from `auto_install_extensions`,
  so they can be added to settings.json.
'
zed-backup() {
  local zed_extensions_index="$HOME/Library/Application Support/Zed/extensions/index.json"
  local settings="$HOME/.dotfiles/dots/zed/settings.json"

  if [[ ! -f "$zed_extensions_index" ]]; then
    echo -ne "  ⚠️  No Zed extensions index found at $zed_extensions_index\n"
    return 1
  fi

  python3 - "$zed_extensions_index" "$settings" <<'PY'
import json, re, sys

with open(sys.argv[1]) as f:
    installed = set(json.load(f).get("extensions", {}))

# settings.json is JSONC: grab the auto_install_extensions block and its keys
with open(sys.argv[2]) as f:
    block = re.search(r'"auto_install_extensions"\s*:\s*\{([^}]*)\}', f.read())
tracked = set(re.findall(r'"([^"]+)"\s*:', block.group(1))) if block else set()

missing = sorted(installed - tracked)
if missing:
    print("  ➕ Installed but not in auto_install_extensions:")
    for ext in missing:
        print(f'     "{ext}": true,')
else:
    print("  👌 Every installed extension is in auto_install_extensions")
PY
}
