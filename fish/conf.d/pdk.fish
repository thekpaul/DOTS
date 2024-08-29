if string match -qr 'pdk*' (prompt_hostname)

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
    set FISH_PATH (which fish)
    if type -q conda; and set -q CONDA_DEFAULT_ENV
      set CONDA_ENV $CONDA_DEFAULT_ENV
      conda deactivate
      exec bash -c "source $(which ic$argv); exec $FISH_PATH -C 'conda activate $CONDA_ENV'"
    else
      exec bash -c "source $(which ic$argv); exec $FISH_PATH"
    end
  else
    echo "FATAL: `ic$argv` not found."
  end
end

end
