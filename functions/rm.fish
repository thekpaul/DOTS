function rm
  if status --is-interactive
    printf "Use the full path i.e. `%s`, consider using trash (`gio trash`)\n" \
      (command -s rm)
    false
  end
end
