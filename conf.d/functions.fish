# FUNCTIONS.fish

function mkcd
    mkdir $argv
    cd $argv
end

function lsa
    ls -AH --group-directories-first $argv
end

function lscd
    lsa $argv
    cd $argv
end

function sumatra
    SumatraPDF.exe $argv
end
