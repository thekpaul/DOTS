function rm
  if status --is-interactive
    set -l RM_ALT (which gio)
    printf "Use the full path i.e. `%s`, consider using trash (`%s`)\n" \
      (command -s rm) (string join ' ' $RM_ALT 'trash')
    if test -n "$argv"
      printf "Would you like to trash with the following command?\n"
      printf "\t$RM_ALT trash %s\n" "$argv"
      read -f REPLY -P "[y/N] > "
      if test $REPLY = 'y'
        command $RM_ALT trash $argv
      else
        false
      end
    else
      false
    end
  end
end
