# NOTE: Currently only supports `x86_64-linux` in user `$HOME` directory.

if test -d $HOME/texlive
  for dir in (lsa $HOME/texlive)
    if not string match --quiet --regex '\D' $dir
      fish_add_path -g $HOME/texlive/$dir/bin/x86_64-linux
    end
  end
end
