set -Ux fish_greeting "Something on Your Mind?"
set -gx GPG_TTY (tty)
rvm default
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/thekpaul/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

if status --is-login
  and test -s $TMUX;
  tmux new -s "main";
end
