if type -q nvim
  complete -c vim --erase;
  complete vim --wraps nvim
else
  # Use default completions
end
