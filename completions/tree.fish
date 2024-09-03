if type -q eza
  complete -c tree --erase
  complete -c tree --wraps eza
else
  # Use default completions
end
