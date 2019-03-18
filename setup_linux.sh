#!/bin/bash

# Prepare apt-get for Sublime Text
# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https
# Select the Stable channel:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get --yes install vim neovim git tree silversearcher-ag postgresql pgadmin3 \
  virtualbox vlc mysql-server mysql-client mysql-workbench xclip gnome-do gimp \
  synaptic nodejs youtube-dl chromium-browser curl gitg libmysqlclient-dev \
  sublime-text npm

# missing: timeedition skype
echo 'Now customise the Shell…'

WERKBANK_DIR=$HOME/werkbank
mkdir -pv $WERKBANK_DIR

mkdir -p $HOME/.ssh
KEY_FILE=$HOME/.ssh/github_rsa

if [[ ! -e $KEY_FILE ]]; then
  ssh-keygen -f $KEY_FILE -t rsa -b 4096 -C 'martineismann@example.com'

  ssh-add $KEY_FILE
  xclip -sel clip < $KEY_FILE.pub

  read -p 'Use the key on the clipboard to create a new key in Github, then press Enter' -n 1 -s
  echo # need a linebreak here
fi

if [[ ! -d $WERKBANK_DIR/dotfiles ]]; then
	git clone git@github.com:meismann/dotfiles.git $WERKBANK_DIR/dotfiles
fi
$WERKBANK_DIR/dotfiles/setup_dotfile_symlinks.sh \
&& $WERKBANK_DIR/dotfiles/setup_generic_cmdline.sh

# Remove Amazon shit:
sudo apt-get --yes remove unity-webapps-common

echo 'Through with everything!'
