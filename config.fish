set -gx GPG_TTY (tty)
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

if not set -q VIRTUAL_ENV_DISABLE_PROMPT
  set -g VIRTUAL_ENV_DISABLE_PROMPT true
end

if [ (uname) = "Darwin" ]
  if test -f /Users/thekpaul/miniconda3/bin/conda
    eval /Users/thekpaul/miniconda3/bin/conda "shell.fish" "hook" $argv | source
  else
    if test -f "/Users/thekpaul/miniconda3/etc/fish/conf.d/conda.fish"
      . "/Users/thekpaul/miniconda3/etc/fish/conf.d/conda.fish"
    else
      set -x PATH "/Users/thekpaul/miniconda3/bin" $PATH
    end
  end
else if [ (uname) = "Linux" ]
  if test -f /home/thekpaul/miniconda3/bin/conda
    eval /home/thekpaul/miniconda3/bin/conda "shell.fish" "hook" $argv | source
  else if test -f /usr/bin/miniconda3/bin/conda
    eval /usr/bin/miniconda3/bin/conda "shell.fish" "hook" $argv | source
  end
else
  echo "Unsupported Operating System: Please report to upstream!"
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# <<< conda initialize <<<

# kill the right prompt __conda_add_prompt 😠
function __conda_add_prompt; end

if test -d /home/thekpaul/.local/bin
  set -x PATH $HOME/.local/bin $PATH
end

if status --is-login
  and test -s $TMUX;
  tmux -2;
end

if [ (uname) = "Darwin" ]
  test -e {$HOME}/.iterm2_shell_integration.fish ;
    and source {$HOME}/.iterm2_shell_integration.fish
end
