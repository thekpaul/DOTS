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
