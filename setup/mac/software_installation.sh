formulas=(
  ag
  ffmpeg
  freac
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
  gimp
  github
  google-chrome
  libreoffice
  macfuse # for borg mount
  MediathekView
  cask nextcloud
  # pg-commander
  # pgadmin3
  sequel-pro
  sublime-text
  telegram
  thunderbird
  transmission
  virtualbox
  vlc
)

echo 'Brewing formulas…' \
  && brew install ${formulas[@]} \
  && echo '… done brewing formulas.' \
  || echo '… some formular installations failed, maybe due to outdated existing versions.'

echo 'Installing apps with Homebrew Cask…' \
  && brew install --cask --language=de ${apps[@]} \
  && echo '…done installing apps with Homebrew Cask.' \
  || echo '… some Cask installations failed, maybe due to outdated existing versions.'
