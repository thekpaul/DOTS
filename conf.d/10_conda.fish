# 10: CONDA.fish
# This file is used to initialise (mini)conda for each session.
# This allows lower-hierarchy snippets to utilise the full extent of the
# current (mini)conda environment.

if test -f $HOME/miniconda3/bin/conda
  eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else if [ (uname) = "Darwin" ]
  if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
  else if test -d $HOME/miniconda3/bin
    fish_add_path -g "$HOME/miniconda3/bin"
  end
end

# NOTE: Moved to `config.fish`
# kill the right prompt __conda_add_prompt 😠
# function __conda_add_prompt; end
