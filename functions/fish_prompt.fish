function fish_prompt
  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

  echo

  set_color yellow
  printf '%s' $USER
  set_color normal
  printf ' at '

  set_color magenta
  echo -n (prompt_hostname)
  set_color normal
  printf '  '

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  # Show GIT BRANCH
  set_color brblack
  if not test -z (fish_git_prompt)
    printf '  [  %s ]' (string sub -s 3 -e -1 (fish_git_prompt))
  end
  set_color normal

  # Line 2
  echo
  if test $VIRTUAL_ENV
    printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
  end
  printf '↪ '
  set_color normal
end
