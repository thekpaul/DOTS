set -gx GPG_TTY (tty)
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# Experimental: Setting user-specific $VISUAL here may have unintended consequences
if not set -q VISUAL; and type -q nvim
  set -g VISUAL (realpath (which nvim))
end

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
  fish_add_path -g $HOME/.local/bin
end

if type -q tmux
  set -l TMUX_SESSIONS (tmux ls 2> /dev/null | awk ' { print $1 } ' | string sub -e -1)
  set -l CURR_SESSION (tmux display-message -p '#S' 2> /dev/null)
  if test -s $TMUX
    set -e CURR_SESSION
  end
  set -l NUM_SESSIONS (count $TMUX_SESSIONS)
  if set -q CURR_SESSION; and contains $CURR_SESSION $TMUX_SESSIONS 2> /dev/null
    set NUM_SESSIONS (math $NUM_SESSIONS - 1)
  end
  if test $NUM_SESSIONS -gt 0
    printf "\n%d other active TMUX session(s) avaliable:\n" $NUM_SESSIONS
    for i in $TMUX_SESSIONS
      if not set -q CURR_SESSION; or not string match -q -- $i $CURR_SESSION
        tmux ls 2> /dev/null | grep "^$i:"
      end
    end
  else
    printf "No other active TMUX sessions.\n"
  end

  if status --is-login
    and test -s $TMUX;
    tmux -2;
  end
end

if [ (uname) = "Darwin" ]
  test -e {$HOME}/.iterm2_shell_integration.fish ;
    and source {$HOME}/.iterm2_shell_integration.fish
end
