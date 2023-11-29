set -gx GPG_TTY (tty)
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

if not set -q VIRTUAL_ENV_DISABLE_PROMPT
  set -g VIRTUAL_ENV_DISABLE_PROMPT true
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/thekpaul/miniconda3/bin/conda
    eval /home/thekpaul/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# kill the right prompt __conda_add_prompt 😠
function __conda_add_prompt; end

set -x PATH $HOME/.local/bin $PATH

if status --is-login
  and test -s $TMUX;
  tmux -2;
end
