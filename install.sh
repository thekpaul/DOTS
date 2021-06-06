# INSTALL_SH: An Interactive Installation Procedure

#!/bin/bash

# Set Script Local Variables

## `tput` Variables
light=$(tput setaf 2; tput bold)
alert=$(tput setaf 1)
reset=$(tput sgr0)
## 
TARGET=""
DOTSDIR=""  # Directory for DOTS Repository
HOMEDIR=""  # Directory for User Home
USRCONF=""  # Directory for User Configuration Files
