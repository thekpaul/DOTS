Nushell Subtree
===

This subtree tracks configurations for the `nu` Nushell executable.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/nushell`:

> [!WARNING]
> While Nushell uses `nu` as its CLI command, and as such DOTS names its
> corresponding subtree `subtree-nu` as well, the configurations are to be
> placed in the `nushell` subdirectory instead of the `nu` subdirectory.

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```sh
   git worktree add $XDG_CONFIG_HOME/nushell -b subtree-nu --track <remote_name>/subtree-nu
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```sh
   git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/nushell -b subtree-nu
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-nu` branch.
   - Unix-based systems where `ln` is available:
     ```sh
     ln (-s) <DOTS_INSTALLATION_PATH>/nushell $XDG_CONFIG_HOME/nushell
     ```
   - Windows systems with PowerShell, using the `New-Item` cmdlet:
     ```pwsh
     New-Item -Path $env:XDG_CONFIG_HOME\nushell -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\nushell
     ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
