formulas=(
  ag
  ffmpeg
  freac
  git
  gpg
  imagemagick
  keepassxc
  MediathekView
  mysql
  npm
  nvim
  tree
  vim
  wget
  yt-dlp
)

apps=(
  alfred
  balenaetcher
  betterbird
  bettertouchtool
  chromium
  clipy
  firefox
  gimp
  github
  libreoffice
  macfuse # for borg mount
  nextcloud
  # pg-commander
  # pgadmin3
  sequel-pro
  sublime-text
  telegram
  # thunderbird
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
