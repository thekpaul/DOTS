# Installation Wizard for DOTS

0. Check all packages are up-to-date: `sudo apt update && sudo apt upgrade -y`
  - Receive sudo password for possible future usage at this time
1. Install Fish, Git, NeoVim
  - `sudo apt install -y fish git neovim`
2. Download DOTS repository
  - Select DOTS repo path
    `git clone https://github.com/thekpaul/DOTS.git $DOTS_PATH`
  - Symlink fish, git_config, nvim to respective paths @ home
    `ln -sf $DOTS_PATH/nvim $HOME/.config/nvim`
    `ln -sf $DOTS_PATH/fish $HOME/.config/fish`
    `ln -sf $DOTS_PATH/git/config $HOME/.gitconfig/`
3. Fish Shell Setup
  - Set Fish as default shell for this user
    `sudo usermod -s /usr/bin/fish $USERNAME`
  - Install OMF
  - Install RVM
    `gpg --keyservers pgp.mit.edu --recv-keys \
      409B6B1796C275462A1703113804BB82D39DC0E3 \
      7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
    `curl -sSL https://get.rvm.io | bash -s stable --rails`
    `omf install rvm`
  - Install NVM
    `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash`
    `omf install nvm`
  - Install PyEnv
    `git clone https://github.com/pyenv/pyenv.git ~/.pyenv`
    `set -Ux PYENV_ROOT $HOME/.pyenv`
    `set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths`
    - After LOGIN SESSION RESTART
      - Install Python Build Dependencies
        `sudo apt install -y make build-essential libssl-dev zlib1g-dev \
          libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
          libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
          libffi-dev liblzma-dev`
      - Install Python2 and Python3, Set global versions
      `pyenv install 2.7.18`
      `pyenv install 3.9.6`
      `pyenv global 3.9.6 2.7.18`
      `python3 -m pip install --upgrade pip`
      `python2 -m pip install --upgrade pip`
4. NeoVim Setup
  - Install NeoVim Dependencies for Health Check:
    `python3 -m pip install neovim`
    `python2 -m pip install neovim`
    `npm install -g neovim`
    `gem install neovim`
  - Install vim-plug
    `sh -c 'curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`
  - Install all NeoVim Plugins Silently: `nvim +PlugInstall +qall`
    Notify that WakaTime plugin is required for next NeoVim session
5. Install TeX
  - WGET installer from CTAN
    `wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
      tar xzf -`
    `sudo perl install-tl*/install-tl --profile $DOTS_PATH/texlive.profile`
