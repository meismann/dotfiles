set nocompatible                " choose no compatibility with legacy vi
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'

" All of your Plugins must be added before the following line
call vundle#end()            " required

syntax enable
set encoding=utf-8
set laststatus=2   " Always show the statusline
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set ai
filetype indent on
"colorscheme codeschool
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
set wildignore+=bower_components,node_modules,tmp,dist
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

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
    \ 'ag %s --files-with-matches -g "" --ignore "\.git$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
