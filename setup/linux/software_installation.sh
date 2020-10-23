packages=(
  chromium-browser
  curl
  gimp
  git
  gitg
  gnome-do
  libmysqlclient-dev
  mysql-client
  mysql-server
  mysql-workbench
  neovim
  nodejs
  npm
  pgadmin3
  postgresql
  silversearcher-ag
  sublime-text
  synaptic
  tree
  vim
  virtualbox
  vlc
  xclip
  youtube-dl
)

# Prepare apt-get for Sublime Text
# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https
# Select the Stable channel:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get update
sudo apt-get --yes install ${packages[@]}

# Remove Amazon shit:
sudo apt-get --yes remove unity-webapps-common

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
