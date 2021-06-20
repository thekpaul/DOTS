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
# 3. Load Fish Shell Configurations Screen
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
# 4. Load Package Installation Configs Screen
# 5. Load Library Installation Configs Screen
# 6. Load Directory Installation Configs Screen
#    - $HOME directory
#    - DOTS Repo Directory

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

# Screens Used
# 1. Main Screen
# 2. Binary Platforms Screen
# 3. Collections Screen
# 4. Packages Screen
# 5. Directories Screen
# 6. Options Screen

################################################################################

class screen:                   # A Class of Screen Objects

    def __init__(self, prompt): # Initialise Screen Object & Define Variables
        self.body = []          # BODY as a List of Single-Line Strings to Print
        self.dict = {}          # DICT as a Dictionary of Selectable Options
        self.read = []          # READ as a List of Selected Character / Digits
        self.prompt = ""        # PROMPT as a Pre-Written String for User Input

    def print(self):            # Print Screen Object to Terminal
        for line in self.body:  # Print ALL lines in the BODY Array
            print(os.linesep)   # Start with a Separating New Line
            print(line)         # Print individual Lines

    def input(self):            # Read User Input for Screen Objects
        temp = set(input(prompt))   # Delete User Input Duplicates
        for x in temp:              # Test individual characters
            if x in self.read:      # Check if character is in READ
                self.read.remove(x) # Remove if already exists
            elif x in self.dict:    # Check if character is an eligible option
                self.read.append(x) # Append if check is positive
        self.read.sort()            # Sort after looping

    def match(self):            # Match User Input with saved Dictionary

  # def <++>

  # def <++>

  # def <++>

  # def <++>

################################################################################

home = screen("Choose Action (Press Enter to Confirm): ")
    # Home
bins = screen("Enter Letter(s) to Select Binary Platforms OR Choose Action")
    # Binary Platforms
cols = screen("Enter Letter(s) to Select Collections OR Choose Action")
    # Collections
pack = screen("Enter Letter(s) to Select Packages OR Choose Action")
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
    (X) Use FISH as Default Shell for User
    (X) Install Oh-My-Fish, a FISH Package Manager
    (X) Install RVM (Ruby) and NVM (Node.js) for FISH
    (X) Automatically Assign Symlinks for Collections

Other Actions:
  [I]  Begin Installation Procedure
  [H]  Help - View Documentations
  [Q]  Quit Procedure

"""

###   >>>>>>            Binary Platforms            <<<<<<   ###
binspage = """
"""

###   >>>>>>               Collection               <<<<<<   ###
colspage = """
###   >>>>>>     Choose Installation Collections    <<<<<<   ###

Supported Libraries:
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

###   >>>>>>             Extra Packages             <<<<<<   ###
packpage = """
###   >>>>>>      Choose Installation Packages      <<<<<<   ###

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
  [4] <++>: $<++>"
  [5] <++>: $<++>"

Actions:
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""

###   >>>>>>          Installation Options          <<<<<<   ###
"""
###   >>>>>>     Configure Installation Options     <<<<<<   ###

  1 [ ] Use FISH as Default Shell for User
  2 [ ] Install Oh-My-Fish, a FISH Package Manager
  3 [ ] Install RVM (Ruby) and NVM (Node.js) for FISH
  4 [ ] Automatically Assign Symlinks for Collections

Actions:
  [R]  RETURN to MAIN MENU
  [Q]  QUIT Installation Procedure

"""
