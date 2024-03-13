Fontconfig Subtree
===

This subtree tracks configurations for the `fontconfig` library.

## Installation

Install this subtree at `$XDG_CONFIG_HOME/fontconfig`:

1. **(Recommended)** Use git-worktree from your local DOTS installation:
   ```sh
   git worktree add $XDG_CONFIG_HOME/fontconfig -b subtree-fontconfig --track <remote_name>/subtree-fontconfig
   ```
   where `remote_name` is the name of the "remote" repository from which your
   DOTS installation is cloned.

2. Standalone installation from remote
   ```sh
   git clone https://github.com/thekpaul/DOTS.git $XDG_CONFIG_HOME/fontconfig -b subtree-fontconfig
   ```

3. (_NOT_ recommended) (Sym)link from your local DOTS installation:
   This will render all future modifications to be commited _directly_ to the
   `main` branch instead of the `subtree-fontconfig` branch.
   ```sh
   ln (-s) <DOTS_INSTALLATION_PATH>/fontconfig $XDG_CONFIG_HOME/fontconfig
   ```
   Make sure to use the _full path_ for `<DOTS_INSTALLATION_PATH>`.

## Contextual Alternatives and Stylistic Sets (`conf.d/00-calt.conf`)

Applied to the "VictorMono Nerd Font" font family only.
Check out the [Victor Mono][victormono] font repository for information on
each stylistic set modifications.

<!-- Upcoming Material!
## Korean Language Fallback Fonts (`conf.d/10-kokr.conf`)

Applied to the "VictorMono Nerd Font" font family only,
uses the "D2CodingLigature Nerd Font" font family.
-->

## Dependencies

The [fontconfig][fc] library is probably installed on most systems by default.
Fonts configured in this subdirectory are:
- [VictorMono Nerd Font (Mono, Propo)][vmnf]
- [D2CodingLigature Nerd Font (Mono, Propo)][d2nf]

Both fonts are downloadable from the [Nerd Fonts Github repository][nfgh],
as well as many other patched fonts.
VictorMono Nerd Font was selected for its outstanding cursive-italic characters,
while D2CodingLigature Nerd Font was selected for its support of Korean
alphabets.

## Meta

Authored and maintained by [Paul Kim](https://thekpaul.dev).

Distributed under the [MIT License][license].

[victormono]: https://github.com/rubjo/victor-mono?tab=readme-ov-file#font-stylistics
[fc]: https://www.freedesktop.org/wiki/Software/fontconfig/
[vmnf]: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/VictorMono.tar.xz
[d2nf]: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/D2Coding.tar.xz
[nfgh]: https://github.com/ryanoasis/nerd-fonts
[license]: ./LICENSE.md
