# 28: NIX.fish
# This snippet is used for Nix(OS).

# Added by Nix single-user installer, modified for portability
if test -e {$HOME}/.nix-profile/etc/profile.d/nix.fish;
  . {$HOME}/.nix-profile/etc/profile.d/nix.fish;
end
