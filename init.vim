" INIT.vim: Initialising Configurations for NeoVim

" GLOBAL BEHAVIOURAL CHANGES {

  " Use `bash` as a POSIX-compatible alternative if the login shell is `fish`.
  if &shell =~# 'fish$'
    set shell=bash
  endif

  " Allow mouse usage in all environments
  set mouse=a

  " Partial Behaviour Changes
  behave mswin
  set virtualedit=onemore "For Consistency in Selective AutoClosing

  " Windows like clipboard
  vnoremap <c-x> "+x
  vnoremap <c-c> "+y
  cnoremap <c-v> <c-r>+
  exe 'ino <script> <C-V>' paste#paste_cmd['i']

  " Un/Redo Like Windows
  nnoremap <C-z> u
  nnoremap <C-y> <C-r>
  inoremap <C-z> <Esc>ui
  inoremap <C-y> <Esc><C-r>i
  "
  " Save Like Windows (Erase all Whitespace)
  inoremap <C-s> <Esc>:%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>a
  nnoremap <C-s> :%s/\s\+$//e<CR>:let @/=""<CR>:update<CR>

  " delete, yank, select a document
  nnoremap dad ggVGd
  nnoremap yad %y
  nnoremap vad ggVG

  set noundofile | "No Undo Files

  " Source Plugin Vimscript
  filetype off
  filetype plugin indent on | "Set plugin loading according to filetype

  set termguicolors " Apply True Coloring in Terminal
  set encoding=utf8 | "Set File Encoding as UTF-8
  let $LANG = 'en_US'
  runtime delmenu.vim
  runtime menu.vim
  set langmenu=en_US.utf8 | "Set Menu Language
  set fileencodings=utf8 | "Set NEW File Encoding to UTF-8
    if (&fileencodings != 'utf8')
      set fileencodings=utf8
    endif | "Set ALL File Encoding to UTF-8
  set number | "Line Numbering
  set expandtab | set shiftwidth=2 | set tabstop=2
  set softtabstop=2 | set smarttab | "Set Tab Spacing
  set cursorline
  augroup CursorColumn
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    au WinLeave * setlocal nocursorcolumn
  augroup END
  set breakindent | set linebreak
  set iskeyword+=\
  let g:tex_flavor = "latex"
  set colorcolumn=80
  set splitbelow | set splitright | "Split below and right of current buffer
  set foldmethod=manual | "Fold Manually
  set nowrap | set sidescroll=8 | "Disable Line Wrapping to Buffer
  set list
  set lcs=trail:X
  set scrolloff=10
  let g:loaded_perl_provider = 0 | "Disable Perl Provision for Neovim

  " Jump Mechanism
  nnoremap <silent> <C-j> /<++><CR>:let @/ = ""<CR>4"_xi
  inoremap <silent> <C-j> <Esc>/<++><CR>:let @/ = ""<CR>4"_xi

  " AutoClose {

    inoremap ( ()<lt>++><Esc>5ha
    inoremap [ []<lt>++><Esc>5ha
    inoremap { {}<lt>++><Esc>5ha
    inoremap {<CR> {<CR>}<ESC>O
    inoremap {;<CR> {<CR>};<ESC>O
    if (&ft != 'tex')
      if (&ft != 'verilog')
        inoremap ' ''<lt>++><Esc>5ha
      endif
      inoremap ` ``<lt>++><Esc>5ha
      inoremap " ""<lt>++><Esc>5ha
    endif

    vmap ( di(<Esc>p
    vmap [ di[<Esc>p
    vmap { di{<Esc>p
    vmap {<CR> di{<CR><Esc>p
    vmap {;<CR> di{;<CR><Esc>p
    if (&ft != 'tex')
      if (&ft != 'verilog')
        vmap ' di'<Esc>p
      endif
      vmap ` di`<Esc>p
      vmap " di"<Esc>p
    endif

  " }

" }

" PLUGINS with Vim-Plug as Plugin Manager {

  call plug#begin('/home/thekpaul/.config/nvim/plugged')
    Plug 'mhinz/vim-startify', { 'on':  'Startify' } " Vim-Startify
    Plug 'kyazdani42/nvim-web-devicons' | " Devicons for NeoVim
    Plug 'romgrk/barbar.nvim' " Tabline Plugin
    Plug 'tpope/vim-fugitive' " Git Wrapper
    Plug 'vim-airline/vim-airline' " Light Statusline
    Plug 'junegunn/seoul256.vim' " Seoul256 Theme
    Plug 'nathanaelkane/vim-indent-guides' " Visual Indentation Guide
    Plug 'tpope/vim-surround' " Surrounder Plugin
    Plug 'wakatime/vim-wakatime' " Official WakaTime Plugin
    Plug 'lervag/vimtex' " Plugin for LaTeX
    Plug 'SirVer/ultisnips' " Snippet Enging Plugin
  call plug#end()

" }

" ADDITIONAL SETTINGS for each External Plugin {

  " Vim-Plug {

    " nnoremap <F12> :PlugInstall<CR>
    "   " Press F12 to Install new Plugins
    " nnoremap <C-F12> :PlugClean<CR>
    "   " Press Ctrl+F12 to Delete Plugins
    " nnoremap <S-F12> :PlugUpdate<CR>
    "   " Press Shift+F12 to Update new Plugins

  " }

  " BarBar {

    let bufline = get(g:, 'bufferline', {}) " Option Dictionary Creation
    let bufline.add_in_buffer_number_order = v:false " Buffer Adding Control
    let bufline.animation = v:true " Enable/disable animations
    let bufline.auto_hide = v:true " Auto-hiding tab bar with single buffer
    let bufline.tabpages = v:true " Current/total tabpages indicator
    let bufline.closable = v:true " Enable/disable close button
    let bufline.clickable = v:true " Clicking tabs | left-click: go to buffer
                      "         | middle-click: delete buffer
    let bufline.icons = 'both' " Icon Display Control
    let bufline.icon_custom_colors = v:false " Icon Highlight Group
    let bufline.maximum_padding = 2 " Maximum Padding Width at Bufferline
    let bufline.maximum_length = 20 " Maximum Buffer Name Length.
    let bufline.semantic_letters = v:true " Buffer-Pick Char Designation
    let bufline.letters =
      \ 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP'
      " New Buffer Letter Designation
    let bufline.no_name_title = v:null " Unnamed Buffer Nomenclature
    " Bufferline icons
    let bufline.icon_separator_active = '|'
    let bufline.icon_separator_inactive = '|'
    let bufline.icon_close_tab = ''
    let bufline.icon_close_tab_modified = '●'
    let bufline.icon_pinned = 'T'
    " Buffer Exclusion from Tabline
    let bufline.exclude_ft = ['javascript']
    let bufline.exclude_name = ['package.json']
    " BarBar Mapping
    " Move to previous/next
    nnoremap <silent> ,, :BufferPrevious<CR>
    nnoremap <silent> ,. :BufferNext<CR>
    " Re-order to previous/next
    nnoremap <silent> ,< :BufferMovePrevious<CR>
    nnoremap <silent> ,> :BufferMoveNext<CR>
    " Goto buffer in position...
    nnoremap <silent> ,1 :BufferGoto 1<CR>
    nnoremap <silent> ,2 :BufferGoto 2<CR>
    nnoremap <silent> ,3 :BufferGoto 3<CR>
    nnoremap <silent> ,4 :BufferGoto 4<CR>
    nnoremap <silent> ,5 :BufferGoto 5<CR>
    nnoremap <silent> ,6 :BufferGoto 6<CR>
    nnoremap <silent> ,7 :BufferGoto 7<CR>
    nnoremap <silent> ,8 :BufferGoto 8<CR>
    nnoremap <silent> ,9 :BufferLast<CR>
    " Pin/unpin buffer
    nnoremap <silent> ,p :BufferPin<CR>
    " Close buffer
    nnoremap <silent> ,c :BufferClose<CR>
    " Wipeout buffer :BufferWipeout<CR>
    " Magic buffer-picking mode :BufferPick<CR>
    " Close commands
    " - :BufferCloseAllButCurrent<CR>
    " - :BufferCloseAllButPinned<CR>
    " - :BufferCloseAllButCurrentOrPinned<CR>
    " - :BufferCloseBuffersLeft<CR>
    " - :BufferCloseBuffersRight<CR>
    " Sort automatically by...
    nnoremap <silent> ,bb :BufferOrderByBufferNumber<CR>
    nnoremap <silent> ,bd :BufferOrderByDirectory<CR>
    nnoremap <silent> ,bl :BufferOrderByLanguage<CR>
    nnoremap <silent> ,bw :BufferOrderByWindowNumber<CR>

  " }

  " VimTeX {

    let g:vimtex_indent_enabled = 0

  " }

  " Seoul256 {

    let g:seoul256_background = 234
    colo seoul256
    highlight EndOfBuffer guifg=bg | "Hide Tildes in Empty Buffer Space for GUI
    highlight EndOfBuffer ctermfg=bg | "Hide Tildes for Terminal

  " }

  " Startify {

    let g:startify_custom_header = [
    \ '                                                 __ __                ',
    \ '                               __               /\ \\ \               ',
    \ '                      __   __ /\_\    ___ ___   \ \ \\ \              ',
    \ '                     /\ \ /\ \\/\ \ /` __` __`\  \ \ \\ \             ',
    \ '                     \ \ \_/ / \ \ \/\ \/\ \/\ \  \ \_\\_\            ',
    \ '                      \ \___/   \ \_\ \_\ \_\ \_\  \/\_\\_\           ',
    \ '                       \/__/     \/_/\/_/\/_/\/_/   \/_//_/           ',
    \ '                                                                      ',
    \ '                                                                      ',
    \ '                        ___                         ___               ',
    \ '                           \      / \  \   /\      /                  ',
    \ '                            \    ㅣ       / ㅣ    /                   ',
    \ '                             \___ \    __/  / ___/                    ',
    \ '                                                                      ',
    \ '                                                                      ']
    set sessionoptions=blank,curdir,folds,help,tabpages,winpos
      " Startify respects Preset Values of the Preceding Options

  " }

  " Vim-indent-guides {

    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify']

  " }

  " Vim-Markdown {

    let g:vim_markdown_folding_disabled = 1

  " }

  " UltiSnips {

    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    let g:UltiSnipsSnippetDirectories = [$HOME."/.config/nvim/UltiSnips"]

  " }

" }
