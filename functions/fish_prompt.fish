function fish_prompt
  # Prerequisite: Check LAST STATUS and set colors
  set -l last_pipestatus $pipestatus
  set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
  set -q fish_color_status
  or set -g fish_color_status red

  # Line 1: "<USER> at <HOST>   <PWD>"
  set_color cyan
  printf '\n%s' $USER
  set_color normal
  printf ' at '
  set_color brred
  printf '%s' (prompt_hostname)
  set_color $fish_color_cwd
  printf '   %s' (prompt_pwd)

  # Show GIT BRANCH
  set_color brblack
  fish_git_prompt "  [  %s at $(git rev-parse --short HEAD 2> /dev/null) ]"
  or fish_hg_prompt "  [ %s ]"
  or fish_fossil_prompt "  [ %s ]"
  set_color normal

  # Show LAST STATUS:
  # If the status was carried over
  #   (if no command is issued or if `set` leaves the status untouched),
  # don't bold it.
  set -l bold_flag --bold
  set -q __fish_prompt_status_generation
    or set -g __fish_prompt_status_generation $status_generation
  if test $__fish_prompt_status_generation = $status_generation
    set bold_flag
  end
  set __fish_prompt_status_generation $status_generation
  set -l status_color (set_color $fish_color_status)
  set -l statusb_color (set_color $bold_flag $fish_color_status)
  set -l print_status (__fish_print_pipestatus "  " "" "|" "$status_color" "$statusb_color" $last_pipestatus)
  if test -z "$print_status"
    set_color brgreen
    printf '  '
    set_color normal
  else
    printf ' %s' $print_status
  end

  # Line 2: Display nested shells if available
  printf '\n ↪'
  string repeat '>' -n (test_nest) -N
  printf ' '
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

function test_nest
  if not test -z $SHLVL
    if test -s $TMUX
      printf '%d' (math max (math $SHLVL - 1), 0)
    else
      printf '%d' (math max (math $SHLVL - 2), 0)
    end
  else
    printf '0' # Currently undetectable without hacks, so noop
  end
end
