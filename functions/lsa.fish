function lsa
  if type -q eza
    eza -AX --group-directories-first --color=auto --icons=auto $argv
  else if [ (uname) = "Darwin" ]
    gls --color=auto -vAH --group-directories-first $argv
  else if [ (uname) = "Linux" ]
    ls --color=auto -vAH --group-directories-first $argv
  end
end
