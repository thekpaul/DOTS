# INSTALL_SH: A Quick vanilla Installation Procedure

#!/bin/bash

# Capture CTRL+C, CTRL+Z and Quit Signals using Trap
trap '' SIGINT
trap ''  SIGQUIT
trap '' SIGTSTP

# Set Script Local Variables and Functions

## Local Variables
TARGET=""
## `tput` Variables
light=$(tput setaf 2; tput bold)
alert=$(tput setaf 1)
reset=$(tput sgr0)
## Directory Variables
DOTSDIR=""    # Directory for DOTS Repository
HOMEDIR=""    # Directory for User Home
USRCONF=""    # Directory for User Configuration Files

## Local Functions
start_procedure() {
    echo "${light}Installing $TARGET and Configurations${reset}"
    APP=$1
    if dpkg -s “$name” &> /dev/null ; then
        echo "$TARGET already installed. Using existing version of $TARGET..."
    else
        echo "Installing $TARGET from the APT-Store...XD"
        sudo apt install $APP -y
    fi
}

endof_procedure() {
    echo "${light}$TARGET Configurations Completed!${reset}"
}


# Install Fish Shell and Configurations
TARGET="Fish Shell"
## Install Fish Shell
start_procedure "fish"
## Symlink Fish Shell Configurations to user $HOME
ln -sf "${DOTSDIR}/DOTS/fish" $USRCONF
## Fish Shell Configurations Complete
endof_procedure

# Install Git and Configurations
TARGET="Git"
## Install Git
start_procedure "git"
## Create GIT_Config if it does not exist
GITCONF="${HOMEDIR}/.gitconfig"
if [ -f "$GITCONF" ]; then
    echo "User Confugiration for Git exists. Will not overwrite."
else
    echo "Submit Email Address: "
    read GITMAIL;
    echo "Submit Name: "
    read GITNAME;
    echo -e "[user]\n\temail = ${GITMAIL}\n\tname = ${GITNAME}" |
        tee -a $HOMEDIR/.gitconfig
fi
## Symlink GIT_Ignore
ln -sf "${DOTSDIR}/DOTS/git/ignore" "${HOMEDIR}/.gitignore"
## Git Configuratiosn Complete
endof_procedure

# Install NeoVim and Configurations
TARGET="NeoVim"
## Install NeoVim
start_procedure "neovim"
## Install `vim-plug`, a Vim plugin manager by `junegunn`
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
## Auto-Install all specified plugins and quit procedure afterwards
nvim +PlugInstall +qall
## Symlink NeoVim Configurations to user $HOME
ln -sf "${DOTSDIR}/DOTS/fish" $USRCONF
## NeoVim Configurations Complete
endof_procedure
