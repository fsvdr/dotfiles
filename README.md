# Dotfiles 🤖⚙️

A little program that configures and customizes a macOS system to my personal preferences.

## 🚀 Install

On a fresh new macOS environment update everything and install Xcode's command line utilities before proceeding:

```
sudo softwareupdate -i -a
xcode-select --install
```

Then install the dotfiles repository:

```
git clone https://github.com/fsvdr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./bin/dotfiles bootstrap
```

This will run the installation script which will go through a few automation tasks:

- Backup of all pre-existing dotfiles
- Configure git credentials
- Symlink dotfiles
- Configure macOS default preferences
- Configure the development environment (brew, node and python)
- Apps installation
- SSH Keys recovery (optional)
- Atom editor configuration and packages installation

## ⌨️ `Dotfiles`

After the first installation, the `dotfiles` command will be available on every terminal.

```
Usage: dotfiles <command>

where <command> is one of:
  help      - Displays this message
  bootstrap - Takes care of setting up your environment as a new one
  backup    - Backs up any previous dotfiles
  git       - Takes care of git dotfiles configuration
  symlink   - Symlinks dotfiles (backup is done first)
  macos     - Apply macOS system defaults
  dev       - Installs dependencies for dev environment
  apps      - Install apps (App Store and via cask)
  atom      - Install atom packages
  update    - Updates packages and pkg managers (OS, brew, npm)
  clean     - Clean up caches (brew, npm)
  disengage - Pack important data up before leaving the ship
  edit      - Open dotfiles in prefered editor
```

If the command is not available you can install it by running `~/.dotfiles/bin symlink`. This will symlink the dotfiles that add the program location to the `PATH` environment variable.

## 🔧 Maintenance

Using the `dotfiles` command you can perform some maintenance task like `clean`ing caches from brew and npm, `update` package managers and even `edit` the dotfiles repository itself.

The sub command `disengage` is meant to help pack important information up before transitioning to another system.

## 📚 Resources

This project was heavily inspired by these awesome repositories:

- [**Zach Holman**'s dotfiles](https://github.com/holman/dotfiles)
- [**Lars Kappert**'s dotfiles](https://github.com/webpro/dotfiles)
- [**Mathias Bynens**'s dotfiles](https://github.com/mathiasbynens/dotfiles)

Other mention worthy resources:

- [**The Bash Guide**](https://guide.bash.academy/) - Awesome project by [**Maarten Billemont**](https://github.com/lhunath) to learn bash programming
- [**Setting Up a Mac Dev Machine From Zero to Hero With Dotfiles**](https://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449)
- [**Getting Started With Dotfiles**](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
