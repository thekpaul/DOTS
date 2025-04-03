Git Subtree
===

This subtree tracks configurations for the `git` Git executable.

## Installation

1. Install this subtree at `$XDG_CONFIG_HOME/git`:

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

2. **Windows only**: (Sym)link `windows.config` to the user's `$HOME` directory
   as `.gitconfig`.<br>
   This provides an additional "global" Git configuration file used only for
   Windows systems.
   ```pwsh
   New-Item -Path $env:USERPROFILE\.gitconfig -ItemType SymbolicLink -Value $env:XDG_CONFIG_HOME\git\windows.config
   ```
   If your `$env:XDG_CONFIG_HOME\git\` is already a (sym)link and you do not
   want to risk (sym)linking to another (sym)link, you can directly (sym)link to
   the file located in the original DOTS installation path:
   ```pwsh
   New-Item -Path $env:USERPROFILE\.gitconfig -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\git\windows.config
   ```

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
