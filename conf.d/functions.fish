# FUNCTIONS.fish

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

if type -q eza
  function lsa --wraps eza
    eza -AX --group-directories-first --color=auto --icons=auto $argv
  end
else if [ (uname) = "Darwin" ]
  function lsa --wraps gls
    gls --color=auto -vAH --group-directories-first $argv
  end
else if [ (uname) = "Linux" ]
  function lsa --wraps ls
    ls --color=auto -vAH --group-directories-first $argv
  end
end

if type -q eza
  function tree
    lsa --tree -lo --no-permissions --time-style "+%y/%m/%d %H:%M" \
        $argv
  end
end

function lscd
  cd $argv
  lsa
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
