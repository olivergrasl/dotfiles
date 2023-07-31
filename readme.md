# Dotfiles

Contains the key settings and access keys stored in dotfiles for easy transfer between systems.

The follwing symlinks need to be made:

.emacs -> .dotfiles/.emacs
.vim -> .dotfiles/vim/.vim
.vimrc -> .dotfiles/vim/.vimrc
.zprofile -> .dotfiles/zsh/.zprofile
.zshrc -> .dotfiles/zsh/.zshrc

## Before you get started

install xcode-extensions
upgrade macos
sudo softwareupdate --install-rosetta

## Install software

Contains a Makefile used to install brew taps and casks. Based on [webpro's dotfiles repo](https://github.com/webpro/dotfiles/tree/master)

### Automatic installation

On a sparkling fresh installation of macOS:

```
sudo softwareupdate -i -a
xcode-select --install'
```


The Xcode Command Line Tools includes git and make (not available on stock macOS). Now there are two options:

Install this repo with curl available:

`bash -c "curl -fsSL https://raw.githubusercontent.com/olivergrasl/dotfiles/master/remote-install.sh"`

This will clone or download this repo to ~/.dotfiles (depending on the availability of git, curl or wget).

Alternatively, clone manually into the desired location:

`git clone https://github.com/olivergrasl/dotfiles.git ~/.dotfiles`

Use the Makefile to install the packages listed above, and symlink the config files (using stow):

```
cd ~/.dotfiles
make
```

#### Post-Installation
* dot dock (set Dock items)
* dot macos (set macOS defaults)
* Mackup
  * Log into iCloud (and wait until synced)
  * cd && ln -s ~/.config/mackup/.mackup.cfg ~
  * mackup restore
* Start Hammerspoon once and set "Launch Hammerspoon at login"
* touch ~/.dotfiles/system/.exports and populate this file with tokens (e.g. export GITHUB_TOKEN=abc)



### Manual Installation

After the automatic installation, the following apps need to be installed by hand:

* Arc
* Mathematica
* WolframEngine
* Archi+coArchi
* Stella
* Starmoney
* Webex Teams

Adjust dock items:

* Safari
* Teams
* Miro
* Mathematica
* Figma
* Outlook

Also need to do the following:

* Install solarized for  mac terminal
* Complete Outlook accounts
* Add fonts
    * Franklin Gothic
* Copy data directory (this is 'non-essential' data that is not backed up ... but contains caches etc. which I don't want to rebuild)


