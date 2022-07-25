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

class Page:

  def __init__(self, name, char, opts):
    self.name = name
    self.char = char
    self.pick = 0
    self.opts = {}
    if len(opts) > 0:
      for i in range(len(opts)):
        self.opts.update(chr(i + 97), opts[i])
    self.size = len(self.opts)

  def print(self):
          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("# {" + self.char + "} " + self.name + ": " + self.pick +
          " out of " + self.size + " specified ")
    print("                                                                ")
    print("  ( ) [c] git                                                   ")
    for item in self..items():
      print("  (" + "V" + ") [" + item[0] + "] " + item[1])
    print("                                                                ")
    print("  Actions                                                       ")
    print("                                                                ")
    print("      [+] Select All Options                                    ")
    print("      [-] Remove All Options                                    ")
    print("      [R] Return to Main Menu                                   ")
    print("                                                                ")

  def exec(self):
    while True:
      self.print()
      input_char = input("  Enter Action: ")
      match input_char:
        case '+':
          continue
        case '-':
          continue
        case 'r' | 'R': break
        case _:
          print("Unacceptable Input; Please Retry")
          continue

def col_func(val, lim):

  while True:

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("# {C} Collections: x out of y specified                         ")
    print("                                                                ")
    print("  ( ) [a] fish                                                  ")
    print("  ( ) [b] nvim                                                  ")
    print("  ( ) [c] git                                                   ")
    print("                                                                ")
    print("  Actions                                                       ")
    print("                                                                ")
    print("      [+] Select All Options                                    ")
    print("      [-] Remove All Options                                    ")
    print("      [R] Return to Main Menu                                   ")
    print("                                                                ")

    input_char = input("  Enter Action: ")

    match input_char:

      case '+':
        val = lim
        continue

      case '-':
        val = 0
        continue

      case 'r' | 'R': return val

      case _:
        print("Unacceptable Input; Please Retry")
        continue

def pac_func(val, lim):

  while True:

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("# {P} Packages: x out of y specified                            ")
    print("                                                                ")
    print("  ( ) [a] fish                                                  ")
    print("  ( ) [b] nvim                                                  ")
    print("  ( ) [c] git                                                   ")
    print("                                                                ")
    print("  Actions                                                       ")
    print("                                                                ")
    print("      [+] Select All Options                                    ")
    print("      [-] Remove All Options                                    ")
    print("      [R] Return to Main Menu                                   ")
    print("                                                                ")

    input_char = input("  Enter Action: ")

    match input_char:

      case '+':
        val = lim
        continue

      case '-':
        val = 0
        continue

      case 'r' | 'R': return val

      case _:
        print("Unacceptable Input; Please Retry")
        continue

def dir_func(val, lim):

  while True:

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("# {D} Directories                                               ")
    print("                                                                ")
    print("  [H] $HOME:                                                    ")
    print("      LINKS: x out of y specified                               ")
    print("      [a] fish:                                                 ")
    print("      [b] nvim:                                                 ")
    print("      [c] git :                                                 ")
    print("                                                                ")
    print("  Actions                                                       ")
    print("                                                                ")
    print("      [+] Select All Options                                    ")
    print("      [-] Remove All Options                                    ")
    print("      [R] Return to Main Menu                                   ")
    print("                                                                ")

    input_char = input("  Enter Action: ")

    match input_char:

      case '+':
        val = lim
        continue

      case '-':
        val = 0
        continue

      case 'r' | 'R': return val

      case _:
        print("Unacceptable Input; Please Retry")
        continue

def opt_func(val, lim):

  while True:

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("# {O} Options                                                   ")
    print("                                                                ")
    print("  ( ) [1] Set FISH as Default Shell                             ")
    print("  ( ) [2] Use SYMLINKS instead of Hard Copying                  ")
    print("                                                                ")
    print("  Actions                                                       ")
    print("                                                                ")
    print("      [+] Select All Options                                    ")
    print("      [-] Remove All Options                                    ")
    print("      [R] Return to Main Menu                                   ")
    print("                                                                ")

    input_char = input("  Enter Action: ")

    match input_char:

      case '+':
        val = lim
        continue

      case '-':
        val = 0
        continue

      case 'r' | 'R': return val

      case _:
        print("Unacceptable Input; Please Retry")
        continue


if __name__ == "__main__": # MAIN Function

  # CHECK if Python is above 3.10 => Necessary for `match-case`
  assert sys.version_info >= (3, 10)

  # Parse Arguments
  p = argparse.ArgumentParser(description = "DOTS Interactive Installer",
                              formatter_class = argparse.ArgumentDefaultsHelpFormatter)
  p.add_argument("-p", "--profile", help = "Installer Profile")
  args = p.parse_args()

  col_set = 0 # Binary Integer for Collections
  pac_set = 0 # Binary Integer for Packages
  dir_set = 0 # Binary Integer for Directories
  opt_set = 0 # Binary Integer for Options

# if args[0] != "": # Profile Location is given => Process profile

  # Supported Collections: FISH | GIT | NVIM | TEX

  # Supported Pacakges:
  #   FISH: fish, omf
  #   GIT : git,  gh
  #   NVIM: nvim
  #   TEX : (tex installation from internet)

  while True: # Start with Printing Main Page

          #1234567890123456789012345678901234567890123456789012345678901234#
    print("                                                                ")
    print("###                DOTS INTERACTIVE INSTALLER                ###")
    print("                                                                ")
    print("     This is the DOTS Interactive Installer, a tool for         ")
    print("     interactively installing and configuring my dotfiles.      ")
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
    print("      LINKS: x out of y specified                               ")    # `x/n symlinks specified`
    print("                                                                ")
    print("  [O] Options                                                   ")    # Options
    print("                                                                ")
    print("      ( ) Set FISH as Default Shell                             ")
    print("      ( ) Use SYMLINKS instead of Hard Copying                  ")
    print("                                                                ")
    print("  Actions                                                       ")    # Interactions
    print("                                                                ")
    print("      [I] Install DOTS                                          ")    # INSTALL
    print("      [S] Save Current Settings to $HOME and Exit               ")    # SAVE
    print("      [Q] Quit Installer                                        ")    # QUIT
    print("                                                                ")

    input_char = input("  Enter Action: ")

    # receive input_char

    return_val = 0

    match input_char:

      case 'c' | 'C': col_set = col_func(col_set, 2 ** 3 - 1) # Collections

      case 'p' | 'P': pac_set = pac_func(pac_set, 2 ** 3 - 1) # Packages

      case 'd' | 'D': dir_set = dir_func(dir_set, 2 ** 3 - 1) # Directories

      case 'o' | 'O': opt_set = opt_func(opt_set, 2 ** 3 - 1) # Options

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

    if return_val: break
    else: continue
