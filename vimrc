execute pathogen#infect()
set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set ai
filetype indent on
colorscheme codeschool
"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
autocmd BufWritePre *.* :%s/\s\+$//e " remove trailing whitespaces

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase smartcase        " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set magic
vnoremap <c-f> y<ESC>/<c-r>"<CR>
set wrap linebreak nolist
set wildmenu
" ret g:CommandTWildIgnore='tmp/**,*/coverage/*,features/vcr_cassettes/*/**'
set number
nnoremap <c-m> :CtrlP<CR>
set suffixesadd+=.js
set suffixesadd+=.rb
set suffixesadd+=.js.coffee
set suffixesadd+=.coffee

" switching easily between panes
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>

function! s:FuncFr(search, replace, where)
  :noautocmd vim /a:search/ a:where
  :set hidden
  :cfirst
  qa
  :%s//a:replace/gce
  :cnf
  @q
  q
  :wa
endfunction

command! -nargs=* Fr call s:FuncFr(<f-args>)

" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working
let &t_Co=256
let mapleader=' '

" From http://velvetpulse.com/2012/11/19/improve-your-ruby-workflow-by-integrating-vim-tmux-pry/
let g:ScreenImpl = 'Tmux'
let g:ScreenShellTmuxInitArgs = '-2'
let g:ScreenShellInitialFocus = 'shell'
let g:ScreenShellQuitOnVimExit = 0
map <F5> :ScreenShellVertical<CR>
command -nargs=? -complete=shellcmd W  :w | :call ScreenShellSend("load '".@%."';")
map <Leader>r :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
map <Leader>e :w<CR> :call ScreenShellSend("cucumber --format=pretty ".@% . ':' . line('.'))<CR>
map <Leader>b :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>

