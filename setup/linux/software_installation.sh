packages=(
  albert
  curl
  flatpak
  gimp
  git
  gitg
  github-desktop
  gnome-shell-extension-manager
  keepassxc
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
  synaptic
  tree
  virtualbox
  #wine
  vlc
  xclip
  # ifconfig
  net-tools
  nextcloud-desktop
  ruby-full
  signal-desktop
  wget
  yt-dlp

  # Dependencies of pdf-crop-margins
  # ghostscript
  # poppler-utils
  # python3-pip
  # python3-setuptools
  # python3-tk

  # Dependencies of borg backup with mount (https://docs.borgbase.com/restore/mount/)
  #fuse
  #libfuse-dev
  #pkg-config
)

# Add repo for Albert
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_24.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_24.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null

# Add repo for Github client
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

# Add repo Signal client
# 1. Install our official public software signing key:
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
# 2. Add our repository to your list of repositories:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

# Add repo for yt-dlp
sudo add-apt-repository ppa:tomtomtom/yt-dlp

# Now install everything
sudo apt update
sudo apt --yes install ${packages[@]} || (echo 'Software install failed!' && exit 1)

# Install Flatpaks
flatpak install -y \
	eu.betterbird.Betterbird \
	org.chromium.Chromium \
	org.apache.directory.studio \
	org.telegram.desktop \
	md.obsidian.Obsidian \
	com.sublimetext.three \
  chat.schildi.desktop \
  org.mozilla.Firefox \
	org.mozilla.Thunderbird
