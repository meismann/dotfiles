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

# From https://pypi.org/project/pdfCropMargins/
# echo 'Installing pdf-crop-margins…' \
#  && pip3 install pdfCropMargins[gui] borgbackup[fuse] --user --upgrade --no-warn-script-location \
#  && echo '… done installing pdf-crop-margins.'
