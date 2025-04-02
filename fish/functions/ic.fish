function ic --description 'IC Scripts Wrapper for Fish'
  argparse --max-args 1 'h/help' -- $argv; or return
  if set -q _flag_help
    printf '%s\n' 'ic - replace current shell process with `ic`-script-enabled new shell process'
    printf '%s\n' ''
    printf '%s\n' 'ic'
    printf '%s\n' 'ic VERSION'
    printf '%s\n' ''
    printf '%s\n' 'DESCRIPTION'
    printf '%s\n' '`ic` is a fish-compatible wrapper function for the `ic`-scripts used to set various environmental variables for electronic design programs.'
    printf '%s\n' 'As fish does not allow sourced bash scripts to alter environmental variables outside of the script execution process,'
    printf '%s\n' 'this function `exec`s a bash instance, sources the script, then `exec`s a new fish instance to inherit variables from the bash instance.'
    printf '%s\n' ''
    printf '%s\n' '· VERSION is the numbered version to apply.'
    printf '%s\n' ''
    printf '%s\n' 'Note that the replaced shell process may not preserve options used when initialising the current shell process.'
    printf '%s\n' ''
    printf '%s\n' 'The following options are available:'
    printf '%s\n' ''
    printf '%s\n\t%s\n' '-h or --help' 'Displays help about using this command.'
    return 0
  end

  if not count $argv > /dev/null
    set -l IC
    for command in (complete -C ic | grep command)
      set -a IC (string match -r "ic\d+" $command)
    end
    set -l IC_NUM (count $IC)
    printf "%d possible scripts: " $IC_NUM
    if test $IC_NUM -gt 0
      echo $IC
      return 0
    else
      echo "returning to shell..."
      return 1
    end
  else if set -q argv[2]
    echo "Too many arguments: only one is supported at this time." >&2
    return 1
  else if type -q ic$argv
    set FISH_PATH (status fish-path)
    if status is-login
      set FISH_PATH "$FISH_PATH -l"
    end
    if type -q conda; and set -q CONDA_DEFAULT_ENV
      set CONDA_ENV $CONDA_DEFAULT_ENV
      exec bash -c "source $(which ic$argv); exec $FISH_PATH -C 'conda deactivate; conda activate $CONDA_ENV'"
    else
      exec bash -c "source $(which ic$argv); exec $FISH_PATH"
    end
  else
    echo "FATAL: `ic$argv` not found." >&2
    return 1
  end
end
