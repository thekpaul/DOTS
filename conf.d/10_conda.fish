# 10: CONDA.fish
# This file is used to initialise (mini)conda for each session.
# This allows lower-hierarchy snippets to utilise the full extent of the
# current (mini)conda environment.

if test -d "$HOME/.local/share/conda"
  set -gx MAMBA_ROOT_PREFIX "$HOME/.local/share/conda"
else
  set -l conda_paths
  if command -q fd 2> /dev/null
    set conda_paths (fd -t x --glob 'conda' . ~)
  else if command -q find 2> /dev/null
    set conda_paths (find $HOME -type f -name "conda" -executable 2> /dev/null)
  end
  for path in $conda_paths
    set -l potential_root (
      string replace --regex '/bin/conda$' '' (
        string match --regex ".*/bin/conda\$" $path
      )
    )
    if test -x "$potential_root/bin/mamba"
      set -gx MAMBA_ROOT_PREFIX $potential_root
    end
  end
end

if test -f $MAMBA_ROOT_PREFIX/bin/conda
  eval $MAMBA_ROOT_PREFIX/bin/conda "shell.fish" "hook" $argv | source
else
  if test -f "$MAMBA_ROOT_PREFIX/etc/fish/conf.d/conda.fish"
    . "$MAMBA_ROOT_PREFIX/etc/fish/conf.d/conda.fish"
  else
    fish_add_path -g "$MAMBA_ROOT_PREFIX/bin" $PATH
  end
end

set -gx MAMBA_EXE "$MAMBA_ROOT_PREFIX/bin/mamba"
if test -f $MAMBA_EXE; and test -x $MAMBA_EXE
  $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
end

# Revert function change from comda/mamba initialisation
functions -e fish_prompt
functions -c __fish_prompt_orig fish_prompt
functions -e __fish_prompt_orig

functions -e fish_right_prompt
functions -c __fish_right_prompt_orig fish_right_prompt
functions -e __fish_right_prompt_orig
