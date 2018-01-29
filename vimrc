set nocompatible                " choose no compatibility with legacy vi
filetype off                  " required

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'kien/ctrlp.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'vim-ruby/vim-ruby'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

syntax enable
set encoding=utf-8
set laststatus=2   " Always show the statusline
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set ai
filetype indent on
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set directory=/tmp//            " Do not clutter workspace with .swp files

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase smartcase        " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set magic
set wrap linebreak nolist
set wildmenu
set wildignore+=bower_components,node_modules,tmp,dist,*.jpg,*.png,*.woff,*.eot,*.ttf
set number
set suffixesadd+=.js
set suffixesadd+=.rb
set suffixesadd+=.js.coffee
set suffixesadd+=.coffee

" switching easily between panes
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>

" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working
let &t_Co=256

let mapleader=' '

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"" Whitespaces
function! TrimWhiteSpace()
  if &ft =~ 'yaml'
    " Dont strip if file type is Yaml
    return
  endif
  let save_cursor = getpos(".")
  :silent! %s/\s\+$//e " remove trailing whitespaces http://vim.wikia.com/wiki/Remove_unwanted_spaces
  :silent! %s/\n\{2,}/\r\r/e " condense lines http://vim.wikia.com/wiki/Remove_unwanted_empty_lines
  :silent! 0;/^\%(\_s*\S\)\@!/,$d " remove trailing blank lines https://stackoverflow.com/questions/7495932/how-can-i-trim-blank-lines-at-the-end-of-file-in-vim
  call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * call TrimWhiteSpace()

" FZF
nmap <BS> :History<CR>
nmap <CR> :Files<CR>
