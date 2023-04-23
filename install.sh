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
wget "https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb"
sudo apt install -y ./nvim-linux64.deb

# 2. Setup Dotfiles and Symlink to `XDG_CONFIG_HOME` (~/.config/)
## Prerequisite: Setup Github CLI (`gh`)
if [ ! -d ~/Projects ];
  mkdir ~/Projects;
fi
gh auth login # Github CLI Login -> Interactive

## Clone Repo and Make Symlinks
gh repo clone thekpaul/DOTS ~/Projects/DOTS -- --origin=github # Clone Repo
ln -sf $HOME/Projects/DOTS/git/config .gitconfig
ln -sf $HOME/Projects/DOTS/nvim ~/.config/nvim
ln -sf $HOME/Projects/DOTS/tmux ~/.config/tmux
ln -sf $HOME/Projects/DOTS/fish ~/.config/fish

# 3. Setup Fish as Default Shell and add Toolchains
sudo usermod -s /usr/bin/fish $USER
