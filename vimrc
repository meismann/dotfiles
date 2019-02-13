set nocompatible                " choose no compatibility with legacy vi
filetype off                  " required

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'kchmck/vim-coffee-script'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'mustache/vim-mustache-handlebars'
Plug 'vim-ruby/vim-ruby'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'chiel92/vim-autoformat'
Plug 'kana/vim-textobj-user' " Dependency of vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'Yggdroot/indentLine'
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
set scrolloff=5          "Start scrolling when 10 lines close to the bottom

" switching easily between panes
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>

" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working
let &t_Co=256

let mapleader=' '
let g:airline_theme='ayu_mirage'
" Indent Guides
let g:indentLine_color_term = 236
let g:indentLine_char = '┆'

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"" Whitespaces
function! TrimWhiteSpace()
  if &ft =~ 'yaml' || &ft =~ 'text'
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
nmap <CR> :GFiles<CR>
nmap <S-Tab> :Files<CR>
nmap <Leader><Tab> :GFiles?<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Autoformat
noremap <c-a> :Autoformat<CR>

" textobject-ruby
runtime macros/matchit.vim

" For Pry: (https://github.com/rking/pry-de/blob/master/vim/ftplugin/ruby_pry.vim)
iabbr bpry require'pry';binding.pry
nnoremap <Leader>bp orequire'pry';binding.pry<esc>:w<cr>

" Add frozen_string_literal to file's head
function! Add_frozen_string_literal_true()
  let save_cursor = getpos(".")
  normal ggO# frozen_string_literal: true
  normal o
  normal cc
  call setpos('.', save_cursor)
  normal jj
endfunction
nnoremap <Leader>fsl :call Add_frozen_string_literal_true()<cr>

nnoremap Q <Nop>

imap <Tab> <C-P>
