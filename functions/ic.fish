function ic --description 'IC Scripts Wrapper for Fish'
  if type -q ic$argv
  # echo (which ic$argv)
    exec bash -c "source $(which ic$argv); exec fish"
  else
    echo "FATAL: `ic$argv` not found."
  end
end
