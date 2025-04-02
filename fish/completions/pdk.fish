set -l PDK_CMDS
for command in (find /opt/mi-env/bin -type f -executable 2> /dev/null | path basename | path sort)
  set -a PDK_CMDS $command
end

if count $PDK_CMDS > /dev/null
  for i in $PDK_CMDS
    complete --command pdk --no-files -n "not __fish_seen_subcommand_from $PDK_CMDS" \
      -a $i -d "New Fish shell with `$i` applied"
  end
else
  complete --command pdk --no-files
end

complete --command ic --no-files --short-option h --long-option help \
  --description "Print help"
