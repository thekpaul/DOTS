if status --is-interactive; and type -q tmux
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
