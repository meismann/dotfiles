#!/bin/bash

echo "Installung Vim plugins with Vim-Plug…"
vim +PlugInstall +qall && echo "… done."

echo "Installing RVM and Bundler…"
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby && \
  source "$HOME/.rvm/scripts/rvm" && \
  # export PATH=$PATH:$HOME/.rvm/bin && \
  gem install bundler && \
  echo "…done."

echo 'Installing Git-completion…'
git clone https://github.com/todb-r7/git-completion.bash.git /tmp/git-completion.bash && \
  sudo cp /tmp/git-completion.bash/git-completion.bash `pkg-config --variable=compatdir bash-completion` && echo '…done.'
