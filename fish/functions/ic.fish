function ic --description 'IC Scripts Wrapper for Fish'
  if not count $argv > /dev/null
    for command in (complete -C ic | grep command)
      string match -r "ic\d+" $command
    end
  else if set -q argv[2]
    echo "Too many arguments: only one is supported at this time."
    return
  else if type -q ic$argv
  # echo (which ic$argv)
    exec bash -c "source $(which ic$argv); exec fish"
  else
    echo "FATAL: `ic$argv` not found."
  end
end
