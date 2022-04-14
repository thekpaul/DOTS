set -Ux fish_greeting "Welcome! Let's get Started..."
cd
rvm default
set -gx PATH /usr/local/texlive/2022/bin/x86_64-linux \
             /usr/local/texlive/2021/bin/x86_64-linux $PATH
status is-interactive; and pyenv init --path | source
pyenv init - | source
