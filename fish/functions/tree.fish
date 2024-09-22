function tree
  if type -q eza
    lsa --tree -lo --no-permissions --time-style "+%y/%m/%d %H:%M" \
        $argv
  else if command -q tree
    command tree $argv
  else
    echo "Function `tree` currently unavailable."
  end
end
