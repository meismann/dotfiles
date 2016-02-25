#!/bin/bash

echo "Installung Vim plugins with Vim-Plug…"
vim +PlugInstall +qall && echo "… done."

echo "Installing RVM and Bundler…"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -sSL https://get.rvm.io | bash -s stable --ruby && \
  source "$HOME/.rvm/scripts/rvm" && \
  # export PATH=$PATH:$HOME/.rvm/bin && \
  gem install bundler && \
  echo "…done."

echo 'Installing Git-completion…'
git clone https://github.com/todb-r7/git-completion.bash.git /tmp/git-completion.bash && \
  sudo cp /tmp/git-completion.bash/git-completion.bash `pkg-config --variable=compatdir bash-completion` && echo '…done.'

