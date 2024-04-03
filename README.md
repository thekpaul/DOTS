# DOTS

> A Dotfiles Organisation and Tracking System

![](header.png)

# Branch README

This branch tests the [indent-blankline.nvim][ibl-nvim] plugin for Neovim,
with the objective to replace [vim-indent-guides][vig].

# Installation

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

[ibl-nvim]: https://github.com/lukas-reineke/indent-blankline.nvim
[vig]: https://github.com/preservim/vim-indent-guides
