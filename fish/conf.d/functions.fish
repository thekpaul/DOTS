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

function lsa
  if [ (uname) = "Darwin" ]
    gls --color=auto -vAH --group-directories-first $argv
  else if [ (uname) = "Linux" ]
    ls --color=auto -vAH --group-directories-first $argv
  else
    echo "Unsupported Operating System: Please report to upstream!"
  end
end

function lscd
  cd $argv
  lsa
end

function vim
  if type -q nvim
    if status --is-login
      and test $TMUX;
      set -l PANE_CNT (tmux list-panes | wc -l);
      if test \( $PANE_CNT -eq 1 \);
        if test (tmux -V) = "tmux 3.4";
          command tmux split-window -dv -l 25%;
        else;
          command tmux split-window -dv -p 25;
        end;
      end;
    end;
    command nvim $argv;
  else
    command vim $argv;
  end
end
