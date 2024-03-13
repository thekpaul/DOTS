# FontConfig Subdirectory

This subdirectory is tracked for `fontconfig` configurations profile.
All files are to be symlinked to the `$XDG_CONFIG_HOME/fontconfig/conf.d`
directory, where they are parsed in order of the number consisting of the
first two digits in the filename.

```sh
ln -sf <DOTS_INSTALLATION_PATH>/fontconfig $HOME/.config/fontconfig/conf.d
```

## Contextual Alternatives and Stylistic Sets (`00-calt.conf`)

Applied to the "VictorMono Nerd Font" font family only.
Check out the [Victor Mono][victormono] font repository for information on
each stylistic set modifications.

<!-- Upcoming Material!
## Korean Language Fallback Fonts (`10-kokr.conf`)

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

[victormono]: https://github.com/rubjo/victor-mono?tab=readme-ov-file#font-stylistics
[fc]: https://www.freedesktop.org/wiki/Software/fontconfig/
[vmnf]: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/VictorMono.tar.xz
[d2nf]: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/D2Coding.tar.xz
[nfgh]: https://github.com/ryanoasis/nerd-fonts
