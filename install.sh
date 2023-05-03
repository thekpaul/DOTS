#! /usr/bin/env bash

# 0. Set Current Directory to $HOME and add Utility Function
cd $HOME

## Check if Current Machine uses WSL
is_wsl() {
  version=$(2> /dev/null cat /proc/version)
  if [[ "$version" == *"Microsoft"* || "$version" == *"microsoft"* ]]; then
    return 0
  else
    return 1
  fi
}

# 1. Install Necessary Packages, Add PPAs and *Clone This Repo!*
## Adding PPAs
sudo apt-add-repository -y ppa:git-core/ppa                                 # Git Core PPA
sudo apt-add-repository -y ppa:fish-shell/release-3                         # Fish Shell v3.X PPA

## Install Github CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

## Update/Upgrading All Pre-installed Packages
sudo apt-get update && sudo apt-get upgrade -y

## Installing NEW Packages
sudo apt-get install -y \
  git fish gh zlib1g zlib1g-dev openssh-server net-tools build-essential \
  ccache gcc-aarch64-linux-gnu obs-build pv flex bison libssl-dev bc     \
  dosfstools kmod iverilog gtkwave zip inkscape openssl cowsay ninja-build

## IF WSL: Install
if is_wsl; then
  sudo apt-get install -y wslu
fi

## Install Neovim 0.8.3 via `.deb` Directly from Repo on Github
wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
sudo apt install -y ./nvim-linux64.deb

# 2. Setup Dotfiles in XDG_CONFIG_HOME with Possible Symlinks
## Prerequisite: Setup Github CLI (`gh`)
gh auth login # Github CLI Login -> Interactive

## Check if `~/.config` Exists: If it does, REMOVE it! (Default Behaviour)
if [ -d "~/.config" ]; then
  rm -rf ~/.config
fi

## Clone Repo and Make Symlinks
if [ ! -d "~/.config" ]; then
  git clone git@github.com:thekpaul/DOTS.git $HOME/.config --origin=github
### ln -sf $HOME/.config/git/config .gitconfig # Git Global Configs go $HOME
else
### NOTE: If `.config` should not be removed at this time, use `Projects/DOTS`
  if [ ! -d $HOME/Projects/ ]; then
    mkdir $HOME/Projects
    gh repo clone thekpaul/DOTS $HOME/Projects/DOTS -- --origin=github # Clone Repo
    ln -sf $HOME/Projects/DOTS/git/config .gitconfig # Git Global Configs go $HOME
    ln -sf $HOME/Projects/DOTS/nvim ~/.config/nvim # Git Global Configs go $HOME
    ln -sf $HOME/Projects/DOTS/fish ~/.config/fish # Git Global Configs go $HOME
    ln -sf $HOME/Projects/DOTS/tmux ~/.config/tmux # Git Global Configs go $HOME
  else
    echo "Cannot Clone Dotfiles from Github: No Empty Directories Available."
    exit -1
  fi
fi

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
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
  tar -xzf install-tl-unx.tar.gz
  if [ -d install-tl-$(date +%Y%m%d) ]; then # Installed as today's date
    cd install-tl-$(date +%Y%m%d) # Move to Latest Unzip
  elif [ -d install-tl-$(date -d '-1 day' +%Y%m%d) ]; then # Installed as yesterday's date
    cd install-tl-$(date -d '-1 day' +%Y%m%d) # Move to Latest Unzip
  fi
  perl install-tl --profile="~/Projects/DOTS/tex/texlive.profile" # Auto Install with Profile
  cd ../ && rm -rf install-tl-* # Clean Installer and Tarball afterwards
else
  echo "Error in Installing TeXLive!"
fi

# 5. Setup Python in Conda with Miniconda and Add Minimal Packages
wget -O Miniconda.sh \
  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda.sh
### if [ $? -eq 0 ]; then
###   conda init fish # Initialise in Fish shell
### else
###   echo "Error in Installing Miniconda!"
### fi
