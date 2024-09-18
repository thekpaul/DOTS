# 29: RUBY.fish
# This snippet is used for Ruby and its Gems.
# It takes an available Ruby version on the system and adds its Gems to $PATH.

if type -q ruby
  if not set -q GEM_HOME
    set -g GEM_HOME (ruby -e 'puts Gem.user_dir' 2> /dev/null)
    fish_add_path -g $GEM_HOME/bin
  end
end
