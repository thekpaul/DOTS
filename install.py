### DOTS INTERACTIVE INSTALLER ###
"""
The DOTS Interactive installer clones my dotfiles repository from Github and
symlinks each subdirectory to its respective target directory.
It may also install and configure required or frequently used programs and
packages from APT or external (verified) sources; however, users may opt out of
these additional installations and configurations at their own discretion.
"""

import os
import sys
import argparse

if __name__ == "__main__": # MAIN Function

  # CHECK if Python is above 3.10 => Necessary for `match-case`

  # Supported Collections: FISH | GIT | NVIM | TEX

  # Supported Pacakges:
  #   FISH: fish, omf
  #   GIT : git,  gh
  #   NVIM: nvim
  #   TEX : (tex installation from internet)

  while True: # Start with Printing Main Page

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("###                DOTS INTERACTIVE INSTALLER                ###")
    print("                                                                ")
    print("     This is the DOTS Interactive Installer, a tool for         ")
    print("     installing and configuring my dotfiles interactively.      ")
    print("                                                                ")
    print("  [C] Collections: x out of y specified                         ")    # Collections
    print("                                                                ")
    print("                                                                ")
    print("  [P] Packages: x out of y specified                            ")    # Packages
    print("                                                                ")
    print("                                                                ")
    print("  [D] Directories                                               ")    # Directories
    print("                                                                ")
    print("      $HOME:                                                    ")    # $HOME
    print("      SYMLINKS: x out of y specified                            ")    # `x/n symlinks specified`
    print("                                                                ")
    print("  [O] Options                                                   ")    # Options
    print("                                                                ")
    print("      ( ) Set FISH as Default Shell                             ")
    print("                                                                ")
    print("  Actions                                                       ")    # Interactions
    print("                                                                ")
    print("      [I] Install DOTS                                          ")    # INSTALL
    print("      [S] Save Current Settings to $HOME and Exit               ")    # SAVE
    print("      [Q] Quit Installer                                        ")    # QUIT
    print("                                                                ")

    match input_char:
      case 'c' | 'C': # Collections
        while True:   # Start with Printing Collections Page

      case 'p' | 'P': # Packages
        while True:   # Start with Printing Packages Page

      case 'd' | 'D': # Directories
        while True:   # Start with Printing Directories Page

      case 'o' | 'O': # Options
        while True:   # Start with Printing Options Page

      case 'i' | 'I': # Begin Installation
        # Commence System-Level Installation
        break

      case 's' | 'S': # Save Current Installer Profile to HOME DIR
        # Save with JSON file
        break

      case 'q' | 'Q': # Exit
        break

      case _: # Unrecognisable => continue
        continue
