function fish_prompt
  set_color cyan
  printf '\n%s' $USER
  set_color normal
  printf ' at '

  set_color brred
  echo -n (prompt_hostname)

  set_color $fish_color_cwd
  printf '   %s' (prompt_pwd)

  # Show GIT BRANCH
  set_color brblack
  fish_git_prompt "  [  %s at $(git rev-parse --short HEAD 2> /dev/null) ]"
  or fish_hg_prompt "  [ %s ]"
  or fish_fossil_prompt "  [ %s ]"
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
  if [ (uname) = "Darwin" ]
    printf "%s" (gdate '+%H:%M [%d %^h (%a)]')
  else if [ (uname) = "Linux" ]
    printf "%s" (date '+%H:%M [%d %^h (%a)]')
  else
    echo "Unsupported OS: Report to upstream!"
  end
  set_color normal
end
