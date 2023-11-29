# TeX Subdirectory

This subdirectory is tracked for installation and configurations profile,
kept up to date with the latest TeXLive distribution found on the official
[TeX Users Group][1].

The `texlive.profile` installation profile is saved from my last installation
of TeXLive 2023, saved on the current user's `$HOME` directory.
It downloads an extensive set of package collections, and should be capable of
compiling most documents, with the exception of bibliographies.

The `texdoc.cnf` configuration file is used to connect the `texdoc` tool to an
external binary called `wslview`, which is used inside a [WSL][2] distribution
to allow Linux files and commands to be opened by Windows native executables.
In this case, documentation called with `texdoc` are opened by the default
PDF viewer specified in Windows.

This configuration file does not seem to used by default - the file must be
copied (or, better, __symlink__ed) to a directory where the TeXLive installation
can detect and use it. For the current setup in which TeXLive is installed in
the user's `$HOME` directory, the recommended path for personal settings is
`$HOME/texmf/texdoc/texdoc.cnf`:
```sh
ln -sf <DOTS_INSTALLATION_PATH>/tex/texdoc.cnf $HOME/texmf/texdoc/texdoc.cnf
```

[1]: https://tug.org/texlive/acquire-netinstall.html
[2]: https://learn.microsoft.com/en-us/windows/wsl/
