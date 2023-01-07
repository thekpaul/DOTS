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
