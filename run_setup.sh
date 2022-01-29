#!/bin/bash

WERKBANK_DIR=$HOME/werkbank
DOTFILES_REPO_DIR=$WERKBANK_DIR/dotfiles
DOTFILES_REPO_HTTPS_URL=https://github.com/meismann/dotfiles.git
DOTFILES_REPO_SSH_URL=git@github.com:meismann/dotfiles.git

install_basic_mac_packages() {
  echo 'Installing basic Mac packages…'
  if [[ ! -x $(which brew) ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  [[ ! -x $(which brew) ]] \
    && echo '… Brew installation failed.' \
    && exit 1

  brew install git
  echo '… done installing basic Mac packages.'
}

install_basic_linux_packages() {
  echo 'Installing basic Linux packages…'
  sudo apt-get update
  sudo apt-get --yes install git xclip curl
  # Spam protection
  useremail='softwerk@'
  useremail=$useremail"eismann.cc"
  git config --global user.email $useremail
  git config --global user.name "Martin Eismann"
  echo '… done installing basic Linux packages.'
}

echo 'Switching from Zsh to Bash…' \
  && chsh -s /bin/bash \
  && echo '… done switching to Bash.'

uname_out=(uname -s)
case $($uname_out) in
    Linux*)
      os=linux
      install_basic_linux_packages
      ;;
    Darwin*)
      os=mac
      install_basic_mac_packages
      ;;
    *)
      echo "OS $(uname_out) unknown, exit."
      exit 1
      ;;
esac

mkdir -p $WERKBANK_DIR

if [[ ! -d $DOTFILES_REPO_DIR ]]; then
  git clone $DOTFILES_REPO_HTTPS_URL $DOTFILES_REPO_DIR \
    || echo 'Cloning dotfiles failed!' && exit 1
else
  cd $DOTFILES_REPO_DIR # && git pull || echo 'Pulling dotfiles failed!' && exit 1
fi

echo 'Setting up SSH key …' \
  && $DOTFILES_REPO_DIR/setup/ssh_key.sh \
  && echo '… done setting up SSH key.' \
  && echo "Changing $DOTFILES_REPO_DIR's origin to be $DOTFILES_REPO_SSH_URL, thus working with now available SSH authentication" \
  && cd $DOTFILES_REPO_DIR \
  && git remote set-url origin $DOTFILES_REPO_SSH_URL \
  && echo "… done changing $DOTFILES_REPO_DIR's origin." \
  && echo 'Installing software pack with package manager …' \
  && $DOTFILES_REPO_DIR/setup/$os/software_installation.sh \
  && echo '… done installing software pack with package manager.' \
  && echo 'Symlinking dotfiles … ' \
  && $DOTFILES_REPO_DIR/setup/dotfile_symlinks.sh \
  && echo '… done symlinking dotfiles.' \
  && echo 'Setting up generic command line programmes (non-package-manager) …' \
  && $DOTFILES_REPO_DIR/setup/generic_cmdline.sh \
  && echo '… done setting up generic command line programmes.' \
  && echo "Setting up $os specific things" \
  && $DOTFILES_REPO_DIR/setup/$os/configuration.sh \
  && echo "… done setting up $os specific things." \
  && echo 'Through with everything!'
