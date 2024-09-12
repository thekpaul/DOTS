set -gx GPG_TTY (tty)
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

if test -d $HOME/.local/bin
  fish_add_path -g $HOME/.local/bin
end

# Experimental: Setting user-specific $VISUAL here may have unintended consequences
if not set -q VISUAL; and type -q nvim
  set -g VISUAL (realpath (which nvim))
end

if not set -q VIRTUAL_ENV_DISABLE_PROMPT
  set -g VIRTUAL_ENV_DISABLE_PROMPT true
end


if test -f $HOME/miniconda3/bin/conda
  eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else if [ (uname) = "Darwin" ]
  if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
  else if test -d $HOME/miniconda3/bin
    fish_add_path -g "$HOME/miniconda3/bin"
  end
# else if [ (uname) = "Linux" ]; and test -f /usr/bin/miniconda3/bin/conda
#   eval /usr/bin/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#   echo "No Miniconda installation found in `\$HOME` directory."
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# <<< conda initialize <<<

# kill the right prompt __conda_add_prompt 😠
function __conda_add_prompt; end

if [ (uname) = "Darwin" ]
  test -e {$HOME}/.iterm2_shell_integration.fish ;
    and source {$HOME}/.iterm2_shell_integration.fish
end
