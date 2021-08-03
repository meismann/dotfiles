packages=(
  chromium-browser
  curl
  gimp
  git
  gitg
  # gnome-do
  libmysqlclient-dev
  mysql-client
  mysql-server
  # mysql-workbench
  neovim
  nodejs
  npm
  pgadmin3
  postgresql
  silversearcher-ag
  sublime-text
  synaptic
  tree
  wine
  vim
  virtualbox
  vlc
  xclip
  youtube-dl

  # Dependencies of rbenv-build:
  autoconf
  bison
  build-essential
  libffi-dev
  libgdbm-dev
  libncurses5-dev
  libreadline-dev
  libreadline-dev
  libssl-dev
  libyaml-dev
  zlib1g-dev

  # Dependencies of pdf-crop-margins
  ghostscript
  poppler-utils
  python3-pip
  python3-setuptools
  python3-tk

  # Dependencies of borg backup with mount (https://docs.borgbase.com/restore/mount/)
  fuse 
  libfuse-dev 
  pkg-config
)

# Prepare apt-get for Sublime Text
# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https
# Select the Stable channel:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

if [ -z "$(find /var/cache/apt/pkgcache.bin -mmin -60)" ]; then
  # The main script (run_setup.sh) will have just run that in most cases
  sudo apt-get update
fi
sudo apt-get --yes install ${packages[@]} || (echo 'Software install failed!' && exit 1)

# Remove Amazon shit:
sudo apt-get --yes remove unity-webapps-common

echo 'Installing rbenv and ruby-build plugin…'
export PATH="\
$HOME/.rbenv/bin:\
$HOME/.rbenv/shims:\
$PATH"

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash \
  && echo '… done installing rbenv etc.'
