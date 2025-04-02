# 11: FUNCTIONS.fish
# This file defines basic functions used in interactive shell sessions.
# If applicable, functions here may be moved to their own, separate functions
# in the `./functions` directory.

function mkcd
  command mkdir $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'

      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end

function lscd --wraps cd
  cd $argv && lsa
end

if type -q nvim
  function vim --wraps nvim
    if status --is-interactive
      and test $TMUX
      set -l PANE_CNT (tmux list-panes | wc -l)
      if test \( $PANE_CNT -eq 1 \)
        if test (tmux -V) = "tmux 3.4"
          command tmux split-window -dv -l 25%
        else
          command tmux split-window -dv -p 25
        end
      end
    end
    command nvim $argv
  end
end
