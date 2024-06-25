# DOTS

> A Dotfiles Organisation and Tracking System

![](header.png)

## Branch README

This branch tests usability for `nix-user-chroot`, a tool that assists any user
to install and run `nix` commands and tools, even without `sudo`.
Currently, as the original `root` user is passed as `nobody`, several
functionalities such as `sudo` itself are unusable.
Until this issue can be mitigated, this branch will not be merged back into the
main branch.

## Installation Script

We are currently working on an interactive installation procedure based on
Python 3 and a vanilla installation script based on Bash. The Python script is
intended for an interactive setup that supports thorough personalisation, while
the Bash script is intended for an automatic, full-scale installation based on
default settings.

The Shell script installer can be downloaded to your CWD with:
```sh
wget https://raw.githubusercontent.com/thekpaul/DOTS/main/install.sh
```

## Manual Install

DOTS can be cloned to a local Git repository:
`git clone https://www.github.com/thekpaul/DOTS.git`

# Meta

Paul Kim – [@thekpaul](https://thekpaul.dev)

Distributed under the MIT license. See ``LICENCE.md`` for more information.
