# FUNCTIONS.fish

function mkcd
  mkdir $argv
  cd $argv
end

function lsa
  if [ (uname) = "Darwin" ]
    gls -AH --group-directories-first $argv
  else if [ (uname) = "Linux" ]
    ls -AH --group-directories-first $argv
  else
    echo "Unsupported Operating System: Please report to upstream!"
  end
end

function lscd
  cd $argv
  lsa
end

function vim
  if status --is-login
    and test $TMUX;
    set -l PANE_CNT (tmux list-panes | wc -l);
    if test \( $PANE_CNT -eq 1 \);
      if test (tput cols) -lt (math 2.5 x (tput lines));
        command tmux split-window -dv -p 25;
      else;
        command tmux split-window -dh -p 25;
      end;
    end;
  end;
  command nvim $argv;
end
