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
  mysql
  wget
  npm
  fzf
)

echo 'Brewing formulas…'
brew install ${formulas[@]}
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install --key-bindings --completion --update-rc

echo 'Installing apps with Homebrew Cask…'
# To get versions in German language:
apps=(
  firefox
  thunderbird
  flash-player
  sublime-text
  gimp
  alfred
  bettertouchtool
  timeedition
  github
  etcher
  # pg-commander
  # pgadmin3
  libreoffice
  slack
  clipy
  google-chrome
  chromedriver
  vlc
  transmission
  sequel-pro
  nextcloud
  telegram
  virtualbox
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --language=de ${apps[@]} && echo '…done.'

echo "Installing Pow…"
curl get.pow.cx | sh && echo '… done'

echo 'Now customise the Shell…'

WERKBANK_DIR=$HOME/werkbank

mkdir -p $HOME/.ssh
KEY_FILE=$HOME/.ssh/github_rsa

if [[ ! -e $KEY_FILE ]]; then
  ssh-keygen -f $KEY_FILE -t rsa -b 4096 -C 'martin@rumpelstilzchen123.cc'

  ssh-add $KEY_FILE
  pbcopy < $KEY_FILE.pub

  read -p 'Use the key on the clipboard to create a new key in Github, then press Enter' -n 1 -s
  echo # need a linebreak here
fi

if [[ ! -e $WERKBANK_DIR/dotfiles/.git ]]; then
  git clone git@github.com:meismann/dotfiles.git $WERKBANK_DIR/dotfiles
fi

$WERKBANK_DIR/dotfiles/setup_dotfile_symlinks.sh \
  && $WERKBANK_DIR/dotfiles/setup_generic_cmdline.sh

echo 'Through with everything!'
