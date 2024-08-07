# FUNCTIONS.fish

function mkcd
  mkdir $argv
  cd $argv
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
