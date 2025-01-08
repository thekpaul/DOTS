function pdk --description 'Environmental Scripts Wrapper for Fish'
  argparse --max-args 1 'h/help' -- $argv; or return
  if set -q _flag_help
    printf '%s\n' 'pdk - replace current shell process with PDK-script-enabled new shell process'
    printf '%s\n' ''
    printf '%s\n' 'pdk'
    printf '%s\n' 'pdk EXECUTABLE'
    printf '%s\n' ''
    printf '%s\n' 'DESCRIPTION'
    printf '%s\n' '`pdk` is a fish-compatible wrapper function for the `pdk`-scripts used to set various environmental variables for electronic design programs.'
    printf '%s\n' 'As fish does not allow sourced bash scripts to alter environmental variables outside of the script execution process,'
    printf '%s\n' 'this function `exec`s a bash instance, sources the script, then `exec`s a new fish instance to inherit variables from the bash instance.'
    printf '%s\n' ''
    printf '%s\n' '· EXECUTABLE is the executable script to apply.'
    printf '%s\n' ''
    printf '%s\n' 'Note that the replaced shell process may not preserve options used when initialising the current shell process.'
    printf '%s\n' ''
    printf '%s\n' 'The following options are available:'
    printf '%s\n' ''
    printf '%s\n\t%s\n' '-h or --help' 'Displays help about using this command.'
    return 0
  end

  if not count $argv > /dev/null
    set -l PDK_CMDS
    for command in (find /opt/mi-env/bin -type f -executable 2> /dev/null | path basename | path sort)
      set -a PDK_CMDS $command
    end
    set -l PDK_CMD_NUM (count $PDK_CMDS)
    printf "%d possible scripts: " $PDK_CMD_NUM
    if test $PDK_CMD_NUM -gt 0
      echo $PDK_CMDS
      return 0
    else
      echo "returning to shell..."
      return 1
    end
  else if set -q argv[2]
    echo "Too many arguments: only one is supported at this time." >&2
    return 1
  else if type -q $argv
    if test (string split ' ' (type $argv) | tail -n1 | path dirname) = '/opt/mi-env/bin'
      set FISH_PATH (status fish-path)
      if status is-login
        set FISH_PATH "$FISH_PATH -l"
      end
      if type -q conda; and set -q CONDA_DEFAULT_ENV
        set CONDA_ENV $CONDA_DEFAULT_ENV
        exec bash -c "source $(which $argv); exec $FISH_PATH -C 'conda deactivate; conda activate $CONDA_ENV'"
      else
        exec bash -c "source $(which $argv); exec $FISH_PATH"
      end
    else
      echo "FATAL: `$argv` not available as a PDK resource." >&2
    end
  else
    echo "FATAL: `$argv` not executable." >&2
    return 1
  end
end
