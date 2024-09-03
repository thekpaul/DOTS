if type -q eza
  function tree
    lsa --tree --level=1 -lo --no-permissions --time-style "+%y/%m/%d %H:%M" \
        $argv
  end
end
