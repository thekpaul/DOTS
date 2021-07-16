###   >>>>>>   DOTS Interactive Installation Procedure for Ubuntu   <<<<<<   ###

###   >>>>>>        Script Writing Guidelines and Flowcharts        <<<<<<   ###

# 1. Check if Target Operating System is Ubuntu
#    - if YES, PROCEED
#    - else (if NO), TERMINATE
# 2. Load Main Screen
#    - Option 1: Set FISH as DEFAULT SHELL
#      -> This option links to the usage of `nvm` and `rvm`
#    - Option 2: Choose Installation Packages
#    - Option 3: Choose Installation Libraries
#    - Option 4: Choose Installation Directories
#    - Install / Help / Quit
# 3. Configure All Objects
#    - Initialise All Screen Objects
#    - Organise All Object Dictionary Variaables
#      - Collections Dictionary: <++>
#      - Packages Dictionary: <++>
#      - Directories Dictionary: <++>
#      - Options Dictionary: <++>
# 4. Load Collection Installation Configs Screen
#    - git -> github cli
#    - fish -> omf
#    - nvim -> plug.vim
#    - tex -> curl texlive & pre-built profile
# 5. Load Package Installation Configs Screen
#    - aptitude
# 6. Load Directory Installation Configs Screen
#    - $HOME directory
#    - DOTS Repo Directory
# 7. Load Fish Shell Configurations Screen
#    - Option 1: Install Fish?
#      - if YES (DEFAULT), PROCEED to Option 2
#      - else (if NO), stay on default shell
#        (inform that Ruby and Node.js must be installed manually)
#    - Option 2: Install Oh-My-Fish?
#      - if YES (DEFAULT), PROCEED to Option 3
#      - else (if NO), install only Fish
#        (inform that a different Package Manager, Ruby and Node.js
#         must be installed manually)
#    - Option 3: Install RVM and NVM Support?
#      - if YES (DEFAULT), Install Fish, OMF, RVM and NVM support
#      - else (if NO), install only Fish and OMF
#        (inform that Ruby and Node.js must be installed manually)

#!/usr/bin/env python3

import os
import sys
import platform
import argparse

if __name__ == "__main__": # Ensure script runs only as main script
    <++>

else:    # 1234567890123456789012345678901234567890123456789012345678901234
    print("This script is designed to be used independently.")
    print("Please use this script according to its intended usage to ensure")
    print("all operations are successfully executed. Thank you.")

################################################################################

class screen:                   # A Class of Screen Objects

    def __init__(self, prompt):     # Initialise Object & Define Variables
        self.body = []              # BODY: List of Single-Line Strings
        self.dict = {}              # DICT: Dictionary of Selectable Options
        self.read = []              # READ: List of Selected Character / Digits
        self.prompt = prompt        # PROMPT: Pre-Written String for User Input
        self.total = self.dict.len()# TOTAL: Total Amount of Options
        self.count = self.read.len()# COUNT: Amount of Selected Options

    def printbody(self):        # Print Screen Object to Terminal
        for line in self.body:          # Loop for all LINEs in SELF_BODY
            print(os.linesep)           # Start with a Separating New Line
            if line == "  # OPTIONS #": # Check for OPTIONS printer trigger
                self.printdict()        # Invoke printdict() function
            else: print(line)           # Print individual Lines

    def printdict(self):        # Print all items in SELF_DICT
        for key in self.dict.keys():        # Loop for all KEYs in SELF_DICT
            print("  " + key + "[")         # Print KEY
            if key in self.read:            # If KEY is already selected
                print("x")                  # Show that KEY is SELECTed
            else: print(" ")                # Else show that KEY is UNSELECTed
            print("]  " + self.dict[key])   # Print VALUE for KEY

    def changeopt(self):        # Read User Input for Screen Objects
        temp = set(input(self.prompt))  # Delete User Input Duplicates
        for x in temp:                  # Test individual characters
            if x in self.read:          # Check if character is in READ
                self.read.remove(x)     # Remove if already exists
            elif x in self.dict.keys(): # Check if character is eligible option
                self.read.append(x)     # Append if check is positive
        self.read.sort()                # Sort after looping

    def changedir(self):        # Select and Change Directory (DIRS only)
        opt = input(self.prompt)            # Read SINGLE input value
        if opt in self.dict.keys():         # Input Option is Available
            self.dict[opt] = set(input("Enter New Path: "))
                                            # Change Path to Input Value
        else: print("Unsupported Option.")  # Input Option is Unavailable

  # def <++>(self, <++>):

################################################################################

# Screens Used
# 1. Main Screen
# 2. Binary Platforms Screen
# 3. Collections Screen
# 4. Packages Screen
# 5. Directories Screen
# 6. Options Screen

################################################################################

home = screen("")
    # Home
bins = screen("Enter Letter(s) to Select Binary Platforms OR Choose Action")
    # Binary Platforms
cols = screen("Enter Letter(s) to Select Collections OR Choose Action")
    # Collections
pacs = screen("Enter Letter(s) to Select Packages OR Choose Action")
    # Packages
dirs = screen("Enter Digit to Edit Directory OR Choose Action")
    # Directories
opts = screen("Enter Letter(s) to Select Options OR Choose Action")
    # Options

###   >>>>>>                  Home                  <<<<<<   ###
homepage = """
###   >>>>>>       DOTS Interactive Installer       <<<<<<   ###

###   >>>>>>   Letters in [BIG BRACKETS] Indicate   <<<<<<   ###
###   >>>>>>   Menu Items for Commands or Options   <<<<<<   ###

  Detected platform: $PLATFORM

  [C]  Choose Installation Collections
    Currently installing $COLCOUNT out of $COLTOTAL Collections

  [P]  Choose Installation Packages
    Currently installing $PACCOUNT out of $PACTOTAL Packages

  [D]  Configure Installation Directories
    - USER HOME: $HOMEDIR
    - USER CONFIGS: $USRCONF
    - DOTS REPO: $DOTSDIR

  [O] Extra Options:
    (X) Use FISH as Default Shell for User (required for b, c)
    (X) Install Oh-My-Fish, a FISH Package Manager
    (X) Install RVM (Ruby) and NVM (Node.js) for FISH
    (X) Automatically Assign Symlinks for Collections

Other Actions:
  [I]  Begin Installation Procedure
  [H]  Help - View Documentations
  [Q]  Quit Procedure

"""

###   >>>>>>      Home Screen Printer Function      <<<<<<   ###
def home():
            ###   >>>>>>                  Home                  <<<<<<   ###
    print( "###   >>>>>>       DOTS Interactive Installer       <<<<<<   ###")
    print( "                                                                ")
    print( "###   >>>>>>   Letters in [BIG BRACKETS] Indicate   <<<<<<   ###")
    print( "###   >>>>>>   Menu Items for Commands or Options   <<<<<<   ###")
    print( "                                                                ")
    print(f"  Detected platform: {platform}                                 ")
    print( "                                                                ")
    print( "  [C]  Choose Installation Collections                          ")
    print(f"    Currently selected {cols.count} out of {cols.total} Collections")
    print( "                                                                ")
    print( "  [P]  Choose Installation Packages                             ")
    print(f"    Currently selected {pacs.count} out of {pacs.total} Packages")
    print( "                                                                ")
    print( "  [D]  Configure Installation Directories                       ")
    print(f"    - USER HOME: $HOMEDIR                                       ")
    print(f"    - USER CONFIGS: $USRCONF                                    ")
    print(f"    - DOTS REPO: $DOTSDIR                                       ")
    print( "                                                                ")
    print( "  [O] Extra Options:                                            ")
    print(f"    (X) Use FISH as Default Shell for User (required for b, c)  ")
    print(f"    (X) Install Oh-My-Fish, a FISH Package Manager              ")
    print(f"    (X) Install RVM (Ruby) and NVM (Node.js) for FISH           ")
    print(f"    (X) Automatically Assign Symlinks for Collections           ")
    print( "                                                                ")
    print( "Other Actions:                                                  ")
    print( "  [I]  Begin Installation Procedure                             ")
    print( "  [H]  Help - View Documentations                               ")
    print( "  [Q]  Quit Procedure                                           ")
    print( "                                                                ")
    opt = input("Choose Action (Press Enter to Confirm): ") # Read SINGLE input value


###   >>>>>>            Binary Platforms            <<<<<<   ###
binspage = """
"""

###   >>>>>>               Collection               <<<<<<   ###
colspage = """
###   >>>>>>   Configure Installation Collections   <<<<<<   ###

Supported Libraries:

  a [ ] Fish Shell (fish)
  b [ ] Git (git)
  c [ ] NeoVim (nvim)
  d [ ] TMuxl (tmux)

Actions:
  [+]  Select ALL
  [-]  Deselect ALL
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""

###   >>>>>>             Extra Packages             <<<<<<   ###
packpage = """
###   >>>>>>   Configure Extra Installed Packages   <<<<<<   ###

Supported Packages:

  a [ ] <++>
  b [ ] <++>
  c [ ] <++>
  d [ ] <++>

Actions:
  [+]  Select ALL
  [-]  Deselect ALL
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""

###   >>>>>>        Installation Directories        <<<<<<   ###
dirspage = """
###   >>>>>>   Configure Installation Directories   <<<<<<   ###

  [1] USER HOME: $HOMEDIR"
  [2] USER CONFIGS: $USRCONF"
  [3] DOTS REPO: $DOTSDIR"

Actions:
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""

###   >>>>>>          Installation Options          <<<<<<   ###
optspage = """
###   >>>>>>     Configure Installation Options     <<<<<<   ###

  a [ ] Use FISH as Default Shell for User (required for b, c)
  b [ ] Install Oh-My-Fish, a FISH Package Manager
  c [ ] Install RVM (Ruby) and NVM (Node.js) for FISH
  d [ ] Automatically Assign Symlinks for Collections

Actions:
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""

###   >>>>>>    Body Matter for Each Page Object    <<<<<<   ###
for line in binspage: bins.body.append(line) # Append lines in BINSPAGE to body
for line in colspage: cols.body.append(line) # Append lines in COLSPAGE to body
for line in pacspage: pacs.body.append(line) # Append lines in PACSPAGE to body
for line in dirspage: dirs.body.append(line) # Append lines in DIRSPAGE to body
for line in optspage: opts.body.append(line) # Append lines in OPTSPAGE to body
