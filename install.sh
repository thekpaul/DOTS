#! /usr/bin/env bash

# 1. Install Necessary Packages, Add PPAs and *Clone This Repo!*
## Adding PPAs
sudo apt-add-repository https://packages.microsoft.com/ubuntu/22.04/prod # Microsoft WSL PPA for Ubuntu 22.04
sudo apt-add-repository ppa:git-core/ppa                                 # Git Core PPA
sudo apt-add-repository https://cli.github.com/packages                  # Github CLI PPA for `gh`
sudo apt-add-repository ppa:fish-shell/release-3                         # Fish Shell v3.X PPA

## Update/Upgrading All Pre-installed Packages
sudo apt-get update && sudo apt-get upgrade -y

## Installing NEW Packages
sudo apt-get install -y \
  git fish gh zlib1g zlib1g-dev openssh-server net-tools build-essential \
  ccache gcc-aarch64-linux-gnu obs-build pv flex bison libssl-dev bc     \
  dosfstools kmod iverilog gtkwave zip inkscape openssl cowsay ninja-build

## Install Neovim 0.8.3 via `.deb` Directly from Repo on Github
wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
sudo apt install -y ./nvim-linux64.deb

# 2. Setup Dotfiles and Symlink to `XDG_CONFIG_HOME` (~/.config/)
## Prerequisite: Setup Github CLI (`gh`)
if [ ! -d ~/Projects ];
  mkdir ~/Projects;
fi
gh auth login # Github CLI Login -> Interactive

## Clone Repo and Make Symlinks
gh repo clone thekpaul/DOTS ~/Projects/DOTS -- --origin=github # Clone Repo
ln -sf $HOME/Projects/DOTS/git/config .gitconfig # Git Global Configs go $HOME
ln -sf $HOME/Projects/DOTS/nvim ~/.config/nvim
ln -sf $HOME/Projects/DOTS/tmux ~/.config/tmux
ln -sf $HOME/Projects/DOTS/fish ~/.config/fish

curl -fLo ~/.config/nvim/autoload --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # Add Plugin Manager for NVim
gh repo clone tmux-plugins/tpm ~/.config/tmux/plugins/tpm             # Add Plugin Manager for TMUX

# 3. Setup Fish as Default Shell and add Toolchains
sudo usermod -s /usr/bin/fish $USER

## OMF
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

## RVM Setup
gpg --keyserver keyserver.ubuntu.com \
  --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
              7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
if [ $? -eq 0 ]; then
  rvm install ruby
else
  echo "Error in Installing RVM!"
fi

# 4. Setup (Latest -> 2023) TeXLive
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

## Only Execute Installation IF Able to Download Installer Tarball
if [ $? -eq 0 ]; then
  cd ~ && tar -xzf install-tl-unx.tar.gz
  cd install-tl-* # Move to Latest Unzip
  perl install-tl --profile="~/Projects/DOTS/tex/texlive.profile" # Auto Install with Profile
  rm -rf install-tl-* # Clean Installer and Tarball afterwards
else
  echo "Error in Installing TeXLive!"
fi

# Setup Python in Conda with Miniconda and Add Minimal Packages
wget -O Miniconda.sh \
  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda.sh
if [ $? -eq 0 ]; then
  conda init fish # Initialise in Fish shell
else
  echo "Error in Installing Miniconda!"
fi
