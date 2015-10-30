#!/bin/bash

echo "Installung Vim plugins with Vundle…"

repo_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $repo_dir \
  && git submodule update --init vim/bundle/Vundle.vim/ \
  && vim +PluginInstall +qall && echo "… done."

echo "Installing RVM and Bundler…"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -sSL https://get.rvm.io | bash -s stable --ruby && \
  source "$HOME/.rvm/scripts/rvm" && \
  # export PATH=$PATH:$HOME/.rvm/bin && \
  gem install bundler && \
  echo "…done."

