set -gx GPG_TTY (tty)
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

# NOTE: This needs to be sourced AFTER possible CONDA.fish snippet injection
# kill the right prompt __conda_add_prompt 😠
function __conda_add_prompt; end

if [ (uname) = "Darwin" ]
  test -e {$HOME}/.iterm2_shell_integration.fish ;
    and source {$HOME}/.iterm2_shell_integration.fish
end

# Remove duplicate items from `PATH` and `LD_LIBRARY_PATH` (if any)
set --path -l NEWPATH
set --path -l PATHDUP
for i in $PATH
  if contains $i $NEWPATH
    set -a PATHDUP $i
  else if not test -z $i
    set -a NEWPATH $i
  end
end
# echo "Removing from path:" $PATHDUP
# echo $NEWPATH
set -g PATH $NEWPATH

if set -q LD_LIBRARY_PATH
  set --path -l NEWLIBS
  set --path -l LIBSDUP
  for i in $LD_LIBRARY_PATH
    if contains $i $NEWLIBS
      set -a LIBSDUP $i
    else if not test -z $i
      set -a NEWLIBS $i
    end
  end
# echo "Removing from libs:" $LIBSDUP
# echo $NEWLIBS
  set -g LD_LIBRARY_PATH $NEWLIBS
end
