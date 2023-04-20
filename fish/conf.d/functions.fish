# FUNCTIONS.fish

function mkcd
  mkdir $argv
  cd $argv
end

function lsa
  ls -AH --group-directories-first $argv
end

function lscd
  cd $argv
  lsa
end

function sumatra
  SumatraPDF.exe $argv
end

function tmux
  command tmux -2 $argv
end

function vim
  if status --is-login
    and test $TMUX;
    set -l PANE_CNT (tmux list-panes | wc -l);
    if test \( $PANE_CNT -eq 1 \);
      command tmux split-window -vp 25;
    end;
  end;
  command nvim $argv;
end
