#!/bin/bash

echo 'Installing FZF …' \
  && (
  [[ -d ~/.fzf/.git ]] \
    || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    ) \
    && ~/.fzf/install --key-bindings --completion --update-rc \
    && echo '… done installing FZF.'

echo "Installung Vim plugins with Vim-Plug…" \
  && vim +PlugInstall +qall \
  && echo "… done installing Vim plugins."

latest_ruby_version=$(rbenv install -l | grep -E '^[0-9.]{3,}' | sort | tail -n 1) \
  && echo "Installing latest Ruby version ($latest_ruby_version)…" \
  && rbenv install -s $latest_ruby_version \
  && echo '… done installing latest Ruby version' \
  && rbenv global $latest_ruby_version \
  && eval "$(rbenv init -)" \
  && gem install bundler

# From https://pypi.org/project/pdfCropMargins/
echo 'Installing pdf-crop-margins…' \
  && pip3 install pdfCropMargins[gui] --user --upgrade \
  && '… done installing pdf-crop-margins.'
