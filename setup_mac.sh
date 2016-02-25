#!/bin/bash

if test ! $(which brew); then
  echo "Installing homebrew…"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo '… done.'
fi

formulas=(
  vim
  git
  tree
  ag
  postgres
  imagemagick
  # Dependency of RVM
  gpg
  youtube-dl
)

echo 'Brewing formulas…'
brew install ${formulas[@]}

echo 'Installing Homebrew Cask…'
brew install caskroom/cask/brew-cask && echo '…done.'

echo 'Installing apps with Homebrew Cask…'
# To get versions in German language:
brew tap caskroom/versions
apps=(
  flash
  sublime-text3

  # these will always be English
  alfred
  bettertouchtool
  timeedition
  github-desktop
  pg-commander
  pgadmin3
  libreoffice
  slack

  # these will automatically be German
  virtualbox
  skype
  google-chrome
  vlc
  transmission
  sequel-pro
  opera

  # these need an explicit German localisation
  firefox-de
  thunderbird-de
  adobe-reader-de
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --appdir="/Applications" ${apps[@]} && echo '…done.'

echo "Installing Pow…"
curl get.pow.cx | sh && echo '… done'

echo 'Now customise the Shell…'

WERKBANK_DIR=$HOME/werkbank
mkdir -pv $WERKBANK_DIR

mkdir -p $HOME/.ssh
KEY_FILE=$HOME/.ssh/github_rsa

if [[ ! -e $KEY_FILE ]]; then
  ssh-keygen -f $KEY_FILE -t rsa -b 4096 -C 'martin@rumpelstilzchen123.cc'

  ssh-add $KEY_FILE
  pbcopy < $KEY_FILE.pub

  read -p 'Use the key on the clipboard to create a new key in Github, then press Enter' -n 1 -s
  echo # need a linebreak here
fi

git clone git@github.com:meismann/dotfiles.git $WERKBANK_DIR/dotfiles \
  && $WERKBANK_DIR/dotfiles/setup_dotfile_symlinks.sh \
  && $WERKBANK_DIR/dotfiles/setup_generic_cmdline.sh

echo 'Through with everything!'
