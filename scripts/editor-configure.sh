#!/usr/bin/env bash

: '
  Symlinks Zed configuration from the dotfiles repo and installs extensions
'
zed-configure() {
  local zed_config_dir="$HOME/.config/zed"
  local dotfiles_zed_dir="${0%/*}/../dots/zed.symlink"

  mkdir -p "$zed_config_dir"

  if [[ -f "$dotfiles_zed_dir/settings.json" ]]; then
    ln -sf "$dotfiles_zed_dir/settings.json" "$zed_config_dir/settings.json"
    echo -ne "  🔗 Linked Zed settings.json\n"
  fi

  if [[ -f "$dotfiles_zed_dir/keymap.json" ]]; then
    ln -sf "$dotfiles_zed_dir/keymap.json" "$zed_config_dir/keymap.json"
    echo -ne "  🔗 Linked Zed keymap.json\n"
  fi

  # Install extensions via Zed CLI
  if [[ -f "$dotfiles_zed_dir/extensions.json" ]]; then
    type zed &>/dev/null
    if [[ $? -eq 0 ]]; then
      echo -ne "  ⏬ Installing Zed extensions\n"
      for ext in $(cat "$dotfiles_zed_dir/extensions.json" | tr -d '[]",' | xargs); do
        zed --install-extension "$ext"
      done
    else
      echo -ne "  ⚠️  Zed CLI not found — install extensions manually from extensions.json\n"
    fi
  fi
}

: '
  Backs up current Zed configuration and extension list into the dotfiles repo
'
zed-backup() {
  local zed_config_dir="$HOME/.config/zed"
  local zed_extensions_index="$HOME/Library/Application Support/Zed/extensions/index.json"
  local dotfiles_zed_dir="${0%/*}/../dots/zed.symlink"

  mkdir -p "$dotfiles_zed_dir"

  if [[ -f "$zed_config_dir/settings.json" ]]; then
    cp "$zed_config_dir/settings.json" "$dotfiles_zed_dir/settings.json"
    echo -ne "  💾 Backed up Zed settings.json\n"
  fi

  if [[ -f "$zed_config_dir/keymap.json" ]]; then
    cp "$zed_config_dir/keymap.json" "$dotfiles_zed_dir/keymap.json"
    echo -ne "  💾 Backed up Zed keymap.json\n"
  fi

  # Extract extension IDs from Zed's index.json
  if [[ -f "$zed_extensions_index" ]]; then
    python3 -c "
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
ext_ids = sorted(data.get('extensions', {}).keys())
print(json.dumps(ext_ids, indent=2))
" "$zed_extensions_index" > "$dotfiles_zed_dir/extensions.json"
    echo -ne "  💾 Backed up Zed extensions list\n"
  fi
}
