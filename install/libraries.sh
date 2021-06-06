# INSTALL/SCRIPTS/LIBS_SH: Library Installation Procedure

# Install Fish Shell and Configurations
    TARGET="Fish Shell"
    start_procedure
    ## Install Fish Shell
    check_procedure "fish"
    ## Symlink Fish Shell Configurations to user $HOME
    ln -sf "${DOTSDIR}/DOTS/fish" $USRCONF
    ## Fish Shell Configurations Complete
    endof_procedure

# Install Git and Configurations
    TARGET="Git"
    start_procedure
    ## Install Git
    check_procedure "git"
    ## Create GIT_Config if it does not exist
    GITCONF="${HOMEDIR}/.gitconfig"
    if [ -f "$GITCONF" ]; then
        echo "User Confugiration for Git exists. Will not overwrite."
    else 
        echo "Submit Email Address: "
        read GITMAIL;
        echo "Submit Name: "
        read GITNAME;
    fi
    ## Symlink GIT_Ignore
    ln -sf "${DOTSDIR}/DOTS/git/ignore" "${HOMEDIR}/.gitignore"
    ## Git Configuratiosn Complete
    endof_procedure

# Install NeoVim and Configurations
    TARGET="NeoVim"
    start_procedure
    ## Install NeoVim
    check_procedure "neovim"
    ## Install `vim-plug`, a Vim plugin manager by `junegunn`
    curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ## Install all specified plugins automatically and quit procedure afterwards
    nvim +PlugInstall +qall
    ## Symlink NeoVim Configurations to user $HOME
    ln -sf "${DOTSDIR}/DOTS/fish" $USRCONF
    ## NeoVim Configurations Complete
    endof_procedure
