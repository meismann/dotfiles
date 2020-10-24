#!/bin/bash

echo "Installung Vim plugins with Vim-Plug…" \
  && vim +PlugInstall +qall \
  && echo "… done installing Vim plugins."

echo "Installing latest Ruby version ($latest_ruby_version)…" \
  && latest_ruby_version=$(rbenv install -l | grep -E '^[0-9.]{3,}' | sort | tail -n 1) \
  && rbenv install -s $latest_ruby_version \
  && echo '… done installing latest Ruby version' \
  && rbenv global $latest_ruby_version \
  && eval "$(rbenv init -)" \
  && gem install bundler
