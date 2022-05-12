set -Ux fish_greeting "Something on Your Mind?"
cd
rvm default
set -gx PATH /usr/local/texlive/2022/bin/x86_64-linux \
             /usr/local/texlive/2021/bin/x86_64-linux $PATH
status is-interactive; and pyenv init --path | source
pyenv init - | source
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
