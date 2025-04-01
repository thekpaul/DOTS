Fish Shell Subtree
===

This subtree tracks configurations for the `fish` Fish shell executable.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/fish`:

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```sh
   git worktree add $XDG_CONFIG_HOME/fish -b subtree-fish --track <remote_name>/subtree-fish
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```sh
   git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/fish -b subtree-fish
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-fish` branch.
   ```sh
   ln (-s) <DOTS_INSTALLATION_PATH>/fish $XDG_CONFIG_HOME/fish
   ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[license]: ./LICENSE.md
