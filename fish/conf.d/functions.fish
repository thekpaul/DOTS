# FUNCTIONS.fish

function mkcd
    mkdir $argv
    cd $argv
end

function lsa
    ls -AH $argv
end

function lscd
    lsa $argv
    cd $argv
end
