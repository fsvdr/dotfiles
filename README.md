# Dotfiles 🤖⚙️

A little program that configures and customizes a macOS system to my personal preferences.

## 🚀 Install

On a fresh new macOS environment update everything and install Xcode's command line utilities before proceeding:

```
sudo softwareupdate -i -a
xcode-select --install
xcodebuild -license
```

Then install the dotfiles repository:

```
git clone https://github.com/fsvdr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./dotfiles configure
```

This will run the installation script which will go through a few automation tasks:

- Configure git credentials
- Symlink dotfiles
- Configure development environment
- Install Applications
- Configure editor
- Configure macOS defaults

## ⌨️ `Dotfiles`

After the first installation, the `dotfiles` command will be available on every terminal.

```
Usage: dotfiles <command>

where <command> is one of:
  help              -   Displays this banner
  configure         -   Runs the entire configuration script on the host machine
  editor-backup     -   Backs up all atom packages to atom-packages.txt
  ssh-keys-restore  -   Sets up SSH keys permissions and adds primary identity to Keychain
```

If the command is not available you can install it by running `~/.dotfiles configure` and skipping through the symlink step. This will symlink the dotfiles that add the program location to the `PATH` environment variable.

## 📚 Resources

This project was heavily inspired by these awesome repositories:

- [**Zach Holman**'s dotfiles](https://github.com/holman/dotfiles)
- [**Lars Kappert**'s dotfiles](https://github.com/webpro/dotfiles)
- [**Mathias Bynens**'s dotfiles](https://github.com/mathiasbynens/dotfiles)

Other mention worthy resources:

- [**Bash Scripting Cheatsheet**](https://devhints.io/bash) - Cheatsheet with plenty of useful bash commands and examples
- [**The Bash Guide**](https://guide.bash.academy/) - Awesome project by [**Maarten Billemont**](https://github.com/lhunath) to learn bash programming
- [**Setting Up a Mac Dev Machine From Zero to Hero With Dotfiles**](https://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449)
- [**Getting Started With Dotfiles**](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
