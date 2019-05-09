set nocompatible                " choose no compatibility with legacy vi
filetype off                  " required

" https://github.com/junegunn/vim-plug
" May need a hack explained here: https://www.reddit.com/r/neovim/comments/3r3nn8/how_to_get_vimplug_to_autoload/
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
Plug 'blueyed/vim-diminactive'
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
set rnu
set suffixesadd+=.js
set suffixesadd+=.rb
set suffixesadd+=.js.coffee
set suffixesadd+=.coffee
set scrolloff=5          "Start scrolling when 10 lines close to the bottom
set cursorline

" switching easily between panes
nnoremap <c-l> <c-w><c-l>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-h> <c-w><c-h>

" http://stackoverflow.com/questions/3761770/iterm-vim-colorscheme-not-working
let &t_Co=256

let mapleader=' '
let g:airline_theme='ayu_mirage'
let g:airline_section_x = ''
let g:airline_section_y = ''
if winwidth(0) > 80
  let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', ' :%3v'])
else
  let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ':%3v'])
endif
" Indent Guides
let g:indentLine_color_term = 240
let g:indentLine_char = '⋮'
let g:indentLine_enabled = 1

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

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
nnoremap <Leader>bp jIrequire'pry';binding.pry<CR><esc>:w<cr>

" Add frozen_string_literal to file's head
function! Add_frozen_string_literal_true()
  let save_cursor = getpos(".")
  normal ggI# frozen_string_literal: true
  execute "normal! a\n"
  normal O
  call setpos('.', save_cursor)
  normal jj
endfunction
nnoremap <Leader>fsl :call Add_frozen_string_literal_true()<cr>

" Paste and indent properly
nnoremap p p=']
nnoremap P P=']
nnoremap <c-p> p

" Autocommands:

"" Whitespaces
function! TrimWhiteSpace()
  if &ft =~ 'yaml' || &ft =~ 'text'
    " Dont strip if file type is Yaml
    return
  endif
  silent! execute "!(git stripspace < " . bufname("%") . ") > " . bufname("%") . ".tmp && mv " . bufname("%") . ".tmp " . bufname("%")
  let l:winview = winsaveview()
  e
  call winrestview(l:winview)
endfunction
autocmd BufWriteCmd * try | undojoin | w | call TrimWhiteSpace() | catch /^Vim\%((\a\+)\)\=:E790/ | w | endtry

colorscheme peachpuff

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
  au VimEnter,WinEnter,BufWinEnter * IndentLinesEnable
  au WinLeave * setlocal norelativenumber
  au WinLeave * IndentLinesDisable
augroup END
highlight CursorlineNR cterm=bold term=bold ctermbg=white
highlight Cursorline cterm=none term=none
highlight ColorColumn ctermbg=237
highlight Search ctermbg=lightgreen
