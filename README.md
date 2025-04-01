PowerShell Subtree
===

This subtree tracks configurations for the `pwsh` PowerShell executable.

> [!NOTE]
> While recent versions of PowerShell 7 are available cross-platform,
> this configuration is expected to be compatible only with Windows machines.
> If you're looking for a Unix-based PowerShell configuration,
> just find a better shell :)

## Installation

Install this subtree at `$env:USERDOMAIN\Documents\PowerShell`:

> [!WARNING]
> While PowerShell uses `pwsh` as its CLI command, and as such DOTS names its
> corresponding subtree `subtree-pwsh` as well, the configurations are to be
> placed in the `PowerShell` subdirectory instead of the `pwsh` subdirectory.

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```pwsh
   git worktree add $env:USERPROFILE\Documents\PowerShell -b subtree-pwsh --track <remote_name>/subtree-pwsh
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```pwsh
   git clone https://github.com/thekpaul/DOTS.git $env:USERPROFILE\Documents\PowerShell -b subtree-pwsh
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-pwsh` branch.
   ```pwsh
   New-Item -Path $env:USERPROFILE\Documents\PowerShell -ItemType SymbolicLink -Value <DOTS_INSTALLATION_PATH>\PowerShell
   ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
