# INSTALL_SH: An Interactive Installation Procedure

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
}

check_procedure() {
    APP=$1
    if dpkg -s “$name” &> /dev/null ; then
        echo "$TARGET already installed. Using existing version of $TARGET..."
    else
        echo "Installing $TARGET from the APT-Store...XD"
        sudo apt install $APP
    fi
}

endof_procedure() {
    echo "${light}$TARGET Configurations Completed!${reset}"
}

# Infinite Loop
while true
    do source install/main.sh
done
