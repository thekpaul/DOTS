# INSTALL/SCRIPTS/MAIN_SH: Installation Procedure Main Screen

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
## Read Main Screen Command
read -N 1 -p "Choose Action: "
case $REPLY in
    C) source libs.sh;; # Choose Installation Libraries
    P) source pacs.sh;; # Choose Installation Packages
    D) source dirs.sh;; # Choose Installation Directories
    I) # Begin Installation Procedure
        source libraries.sh
        source packages.sh ;;
    H) # Help - View Documentations
        xdg-open https://www.github.com/thekpaul/DOTS;; 
    Q) break;; # Quit Procedure
    *) echo "Undefined Input; Please Try Again"
esac
