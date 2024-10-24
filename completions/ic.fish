set -l IC
for command in (complete -C ic | grep command)
  set -a IC (string sub -s 3 (string match -r "ic\d+" $command))
end

for i in $IC
  complete --command ic --no-files -n "not __fish_seen_subcommand_from $IC" \
    -a $i -d "Apply `ic$i`"
end
complete --command ic --no-files --short-option h --long-option help \
  --description "Print help"
