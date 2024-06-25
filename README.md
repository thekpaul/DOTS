## Branch README

This branch tests the usability of `nix-user-chroot`, a tool that enables
any user to install and run `nix` commands and tools, even without root access,
on the current fish-shell configuration.
Currently, as the original `root` user is passed as `nobody`,
several functionalities such as `sudo` itself are unusable.
Until this issue can be mitigated, this branch will not be merged back into the
main branch.
