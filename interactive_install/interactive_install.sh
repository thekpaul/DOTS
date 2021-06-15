# INTERACTIVE_INSTALL_SH: An Interactive Installation Procedure

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
## Counter Variables
LIBCOUNT=""   # Number of Libraries Selected
LIBTOTAL=""   # Number of Libraries in Total
PACTOTAL=""   # Number of Packages Selected
PACCOUNT=""   # Number of Packages in Total
## Input Read Variables
LIBSTR=""     # Input String of Library Selection
PACSTR=""     # Input String of Package Selection
DIRINT=""     # Input Digit from Directories Screen
OLDDIR=""     # Directory String Before Change
NEWDIR=""     # Directory String After Change

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

################################################################################
#####                                                                      #####
#####   >>>>>>>>>>>>>>>>>>>>       SUBSCRIPTS       <<<<<<<<<<<<<<<<<<<<   #####

main() { # Installation Procedure Main Screen
    # Load Main Screen
    echo ">>>>>>>>   Welcome to the DOTS Installation Procedure   <<<<<<<<"
    echo "                                                                "
    echo ">>>>>>>>>>>>   Letters in [BIG BRACKETS] Indicate   <<<<<<<<<<<<"
    echo ">>>>>>>>>>>>   Menu Items for Commands or Options   <<<<<<<<<<<<"
    echo "                                                                "
    echo "  [C]  Choose Installation Libraries                            "
    echo "    Currently installing $LIBCOUNT out of $LIBTOTAL Libraries   "
    echo "                                                                "
    echo "  [P]  Choose Installation Packages                             "
    echo "    Currently installing $PACCOUNT out of $PACTOTAL Packages    "
    echo "                                                                "
    echo "  [D]  Configure Installation Directories                       "
    echo "    - USER HOME: $HOMEDIR                                       "
    echo "    - USER CONFIGS: $USRCONF                                    "
    echo "    - DOTS REPO: $DOTSDIR                                       "
    echo "    - <++>: $<++>                                               "
    echo "    - <++>: $<++>                                               "
    echo "                                                                "
    echo "Other Actions:                                                  "
    echo "  [I]  Begin Installation Procedure                             "
    echo "  [H]  Help - View Documentations                               "
    echo "  [Q]  Quit Procedure                                           "
    echo "                                                                "
    # Read Main Screen Command
    while true
        do read -p "Choose Action (Press Enter to Confirm): "
        case $REPLY in
            C | c ) libs; break;; # Choose Installation Libraries
            P | p ) pacs; break;; # Choose Installation Packages
            D | d ) dirs; break;; # Choose Installation Directories
            I | i ) # Begin Installation Procedure
                    libraries; packages; break;;
            H | h ) # Help - View Documentations
                    more help.txt; break;;
            Q | q ) exit;; # Quit Procedure
            *) echo "Undefined Input; Please Try Again"
        esac
    done
}

## == == == == == == == == == == == == == == == == == == == == == == == == == ##

libs() { # Installation Procedure Libs Screen
    # Load Libs Screen
    echo ">>>>>>>>>>>>      Choose Installation Libraries     <<<<<<<<<<<<"
    echo "                                                                "
    echo "Supported Libraries:                                            "
    echo "                                                                "
    echo "Actions:                                                        "
    echo "  [+]  Select ALL                                               "
    echo "  [-]  Deselect ALL                                             "
    echo "  [R]  RETURN to MAIN MENU                                      "
    echo "  [Q]  QUIT Installation Procedure                              "
    echo "                                                                "
    echo "Enter Letter(s) to Select Libraries OR Choose Action            "
    while true
        do read -p "(Press Enter to Confirm): "
        case $REPLY in
            R | r ) break;; # Quit Procedure
            Q | q ) exit;; # Quit Procedure
            *) echo "Undefined Input; Please Try Again"
        esac
    done
}

## == == == == == == == == == == == == == == == == == == == == == == == == == ##

pacs() { # Installation Procedure Pacs Screen
    # Load Pacs Screen
    echo ">>>>>>>>>>>>      Choose Installation Packages      <<<<<<<<<<<<"
    echo "                                                                "
    echo "Supported Packages:                                             "
    echo "                                                                "
    echo "Actions:                                                        "
    echo "  [+]  Select ALL                                               "
    echo "  [-]  Deselect ALL                                             "
    echo "  [R]  RETURN to MAIN MENU                                      "
    echo "  [Q]  QUIT Installation Procedure                              "
    echo "                                                                "
    echo "Enter Letter(s) to Select Packages OR Choose Action             "
    while true
        do read -p "(Press Enter to Confirm): "
        case $REPLY in
            R | r ) break;; # Quit Procedure
            Q | q ) exit;; # Quit Procedure
            *) echo "Undefined Input; Please Try Again"
        esac
    done
}

## == == == == == == == == == == == == == == == == == == == == == == == == == ##

dirs() { # Installation Procedure Dirs Screen
    # Load Dirs Screen
    echo ">>>>>>>>>>>>   Configure Installation Directories   <<<<<<<<<<<<"
    echo "  [1] USER HOME: $HOMEDIR"
    echo "  [2] USER CONFIGS: $USRCONF"
    echo "  [3] DOTS REPO: $DOTSDIR"
    echo "  [4] <++>: $<++>"
    echo "  [5] <++>: $<++>"
    echo "                                                                "
    echo "Actions:                                                        "
    echo "  [R]  RETURN to MAIN MENU                                      "
    echo "  [Q]  QUIT Installation Procedure                              "
    echo "                                                                "
    echo "Enter Digits to Select Directory OR Choose Action               "
    while true
        do read -p "(Press Enter to Confirm): "
        case $REPLY in
            R | r ) break;; # Quit Procedure
            Q | q ) exit;; # Quit Procedure
            *) echo "Undefined Input; Please Try Again"
        esac
    done
}

diredit() { # Changing Installation Directory
    CHANGE=$1
}

## == == == == == == == == == == == == == == == == == == == == == == == == == ##

libraries() { # Library Installation Procedure
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
}

## == == == == == == == == == == == == == == == == == == == == == == == == == ##

# PACKAGES_SH: Package Installation Procedure

# Parsing Provided Input String

# Download from the APT_Store

##### >>>>>>>>>>>>>>>>>>>>>>       SUBSCRIPTS       <<<<<<<<<<<<<<<<<<<<<< #####
#####                                                                      #####
################################################################################

# Infinite Loop
while true
    do main
done
