bat Subtree
===

This subtree tracks configurations for the `bat` executable.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/bat`:

> [!IMPORTANT]
> The default configurations path for bat on Windows does not seem to respect
> any user-determined `$XDG_CONFIG_HOME` environmental variable; instead, it
> uses the `$env:APPDATA` variable set by the system.
> As such, this subtree should be installed at `$env:APPDATA\bat`.

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   - Unix-based systems using `$XDG_CONFIG_HOME`:
     ```sh
     git worktree add $XDG_CONFIG_HOME/bat -b subtree-bat --track <remote_name>/subtree-bat
     ```
   - Windows systems with PowerShell, using `$env:APPDATA`:
     ```pwsh
     git worktree add $env:APPDATA\bat -b subtree-bat --track <remote_name>/subtree-bat
     ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   - Unix-based systems using `$XDG_CONFIG_HOME`:
     ```sh
     git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/bat -b subtree-bat
     ```
   - Windows systems with PowerShell, using `$env:APPDATA`:
     ```pwsh
     git clone https://github.com/thekpaul/DOTS.git $env:APPDATA\bat -b subtree-bat
     ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-bat` branch.
   - Unix-based systems where `ln` is available:
     ```sh
     ln (-s) <DOTS_INSTALLATION_PATH>/bat $XDG_CONFIG_HOME/bat
     ```
   - Windows systems with PowerShell, using the `New-Item` cmdlet:
     ```pwsh
     New-Item -Path $env:APPDATA\bat -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\bat
     ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
