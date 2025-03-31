Git Subtree
===

This subtree tracks configurations for the `git` Git executable.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/git`:

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```sh
   git worktree add $XDG_CONFIG_HOME/git -b subtree-git --track <remote_name>/subtree-git
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```sh
   git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/git -b subtree-git
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-git` branch.
   - Unix-based systems where `ln` is available:
     ```sh
     ln (-s) <DOTS_INSTALLATION_PATH>/git $XDG_CONFIG_HOME/git
     ```
   - Windows systems with PowerShell, using the `New-Item` cmdlet:
     ```pwsh
     New-Item -Path $env:XDG_CONFIG_HOME\git -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\git
     ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
