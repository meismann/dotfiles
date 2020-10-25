formulas=(
  ag
  ffmpeg
  git
  gpg
  imagemagick
  mysql
  npm
  nvim
  postgres
  rbenv
  tree
  vim
  wget
  youtube-dl
)

apps=(
  alfred
  balenaetcher
  bettertouchtool
  chromedriver
  clipy
  firefox
  flash-player
  gimp
  github
  google-chrome
  libreoffice
  nextcloud
  # pg-commander
  # pgadmin3
  sequel-pro
  slack
  sublime-text
  telegram
  thunderbird
  transmission
  virtualbox
  vlc
)

echo "Installing Pow…" \
  && curl get.pow.cx | sh \
  && echo '… done installing Pow.'

echo 'Brewing formulas…' \
  && brew install ${formulas[@]} \
  && echo '… done brewing formulas.' \
  || echo '… some formular installations failed, maybe due to outdated existing versions.'

echo 'Installing apps with Homebrew Cask…' \
  && brew cask install --language=de ${apps[@]} \
  && echo '…done installing apps with Homebrew Cask.' \
  || echo '… some Cask installations failed, maybe due to outdated existing versions.'
