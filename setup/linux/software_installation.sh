packages=(
  chromium-browser
  curl
  gimp
  git
  gitg
  # gnome-do
  #libmysqlclient-dev
  #mysql-client
  #mysql-server
  # mysql-workbench
  neovim
  nodejs
  npm
  #pgadmin3
  #postgresql
  silversearcher-ag
  #sublime-text
  synaptic
  tree
  virtualbox
  #wine
  #vim
  vlc
  xclip
  youtube-dl
  # ifconfig
  net-tools

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
  #fuse 
  #libfuse-dev 
  #pkg-config
)

# Prepare apt for Sublime Text
# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# Ensure apt is set up to work with https sources:
sudo apt install apt-transport-https
# Select the Stable channel:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

if [ -z "$(find /var/cache/apt/pkgcache.bin -mmin -60)" ]; then
  # The main script (run_setup.sh) will have just run that in most cases
  sudo apt update
fi
sudo apt --yes install ${packages[@]} || (echo 'Software install failed!' && exit 1)

# Remove Amazon shit:
sudo apt --yes remove unity-webapps-common

echo 'Installing rbenv and ruby-build plugin…'
export PATH="\
$HOME/.rbenv/bin:\
$HOME/.rbenv/shims:\
$PATH"

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash \
  && echo '… done installing rbenv etc.'

wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo tee /etc/apt/trusted.gpg.d/shiftkey-desktop.asc > /dev/null
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftkey-desktop.list'
sudo apt update
sudo apt install github-desktop

# Install Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop
