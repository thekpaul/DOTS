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
  while True: # Start with Printing Main Page
    match input_char:
      case 'c' | 'C': # Collections
      case 'p' | 'P': # Packages
      case 'o' | 'O': # Options
      case _: # Unrecognisable => continue