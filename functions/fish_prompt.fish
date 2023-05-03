function fish_prompt
  if not set -q VIRTUAL_ENV_DISABLE_PROMPT
    set -g VIRTUAL_ENV_DISABLE_PROMPT true
  end

  echo

  set_color cyan
  printf '%s' $USER
  set_color normal
  printf ' at '

  set_color brred
  echo -n (prompt_hostname)

  set_color $fish_color_cwd
  printf '  %s' (prompt_pwd)

  # Show GIT BRANCH
  set_color brblack
  if not test -z (fish_git_prompt)
    printf '  [  %s ]' (string sub -s 3 -e -1 (fish_git_prompt))
  end
  set_color normal

  # Line 2
  echo
  printf '↪ '
end


function fish_right_prompt
  if test $CONDA_PROMPT_MODIFIER
    printf " %s" (set_color green; basename $CONDA_PROMPT_MODIFIER)
  end
  set_color brblack
  printf "%s" (date '+%H:%M [%d %^h (%a)]')
  set_color normal
end
