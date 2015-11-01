#!/bin/bash

sudo apt-get --yes install vim git tree silversearcher-ag postgresql pgadmin3 \
  virtualbox vlc mysql-server mysql-client mysql-workbench xclip gnome-do gimp \
  synaptic

# missing: timeedition sublime skype
echo 'Now customise the Shell…'

WERKBANK_DIR=$HOME/werkbank
mkdir -pv $WERKBANK_DIR

mkdir -p $HOME/.ssh
KEY_FILE=$HOME/.ssh/github_rsa

if [[ ! -e $KEY_FILE ]]; then
  ssh-keygen -f $KEY_FILE -t rsa -b 4096 -C 'martin@rumpelstilzchen123.cc'

  ssh-add $KEY_FILE
  xclip -sel clip < $KEY_FILE.pub

  read -p 'Use the key on the clipboard to create a new key in Github, then press Enter' -n 1 -s
  echo # need a linebreak here
fi

git clone git@github.com:meismann/dotfiles.git $WERKBANK_DIR/dotfiles \
  && $WERKBANK_DIR/dotfiles/setup_dotfile_symlinks.sh \
  && $WERKBANK_DIR/dotfiles/setup_generic_cmdline.sh

sudo mkdir -p /usr/local/etc/bash_completion.d
git clone https://github.com/todb-r7/git-completion.bash.git /tmp/git-completion.bash && \
  sudo cp /tmp/git-completion.bash/git-completion.bash /usr/local/etc/bash_completion.d/

# Remove Amazon shit:
sudo apt-get remove unity-webapps-common

echo 'Through with everything!'
