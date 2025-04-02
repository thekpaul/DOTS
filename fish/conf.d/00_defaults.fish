# 00: DEFAULTS.fish
# This file is sourced FIRST in every session.
# It is used to set environmental variables and other defaults
# that are used in other snippets.

if test -d $HOME/.local/bin
  fish_add_path -g $HOME/.local/bin
end

if not set -q VISUAL; and type -q nvim
  set -g VISUAL (realpath (which nvim))
end

if not set -q VIRTUAL_ENV_DISABLE_PROMPT
  set -g VIRTUAL_ENV_DISABLE_PROMPT true
end
