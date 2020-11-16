" INIT.vim: Initialising Configuration for NeoVim

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

execute("source " . s:path . "/init/general.vim")
execute("source " . s:path . "/init/plugins.vim")
execute("source " . s:path . "/init/mapping.vim")
