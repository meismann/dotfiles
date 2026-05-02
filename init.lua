-- Functions
local api = vim.api
local fn = vim.fn

local function write_and_trim_whitespace()
  api.nvim_command('write')
  local ft = vim.bo.filetype or ""
  if ft:match('yaml') or ft:match('text') then
    return
  end
  local bufname = fn.bufname('%')
  if bufname == '' then return end
  local cmd = 'buff=$(git stripspace < ' .. fn.shellescape(bufname) .. ') && echo "$buff" > ' .. fn.shellescape(bufname)
  fn.system(cmd)
  api.nvim_command('normal! me')
  api.nvim_command('edit')
  api.nvim_command('normal! `e')
end

local function add_frozen_string_literal_true()
  local save_cursor = fn.getpos('.')
  api.nvim_command('normal! ggI# frozen_string_literal: true')
  api.nvim_command('normal! a\\n')
  api.nvim_command('normal! O')
  fn.setpos('.', save_cursor)
  api.nvim_command('normal! jj')
end

-- Mapping for frozen string literal
api.nvim_set_keymap('n', '<Leader>fsl', ':lua add_frozen_string_literal_true()<CR>', { noremap = true, silent = true })

-- Basic options
vim.o.compatible = false
vim.cmd('filetype off')

-- plugin manager: vim-plug via vim.fn['plug#begin'] / plug#end
-- If you manage plugins with packer or other plugin manager, adapt accordingly.
vim.fn['plug#begin'](home .. '/.vim/plugged')
vim.fn['plug']('easymotion/vim-easymotion')
vim.fn['plug']('vim-airline/vim-airline')
vim.fn['plug']('vim-airline/vim-airline-themes')
vim.fn['plug']('tpope/vim-rails')
vim.fn['plug']('tpope/vim-rake')
vim.fn['plug']('vim-ruby/vim-ruby')
vim.fn['plug']('junegunn/fzf', { ['do'] = { function() vim.fn['fzf#install']() end } })
vim.fn['plug']('junegunn/fzf.vim')
vim.fn['plug']('chiel92/vim-autoformat')
vim.fn['plug']('kana/vim-textobj-user')
vim.fn['plug']('nelstrom/vim-textobj-rubyblock')
vim.fn['plug']('Yggdroot/indentLine')
vim.fn['plug']('blueyed/vim-diminactive')
vim.fn['plug']('slim-template/vim-slim')
vim.fn['plug']('tpope/vim-eunuch')
vim.fn['plug']('nicwest/vim-camelsnek')
vim.fn['plug']('pangloss/vim-javascript')
vim.fn['plug']('leafgarland/typescript-vim')
vim.fn['plug']('leafOfTree/vim-vue-plugin')
vim.fn['plug#end']()

vim.cmd('syntax enable')
vim.o.encoding = 'utf-8'
vim.o.laststatus = 2
vim.cmd('filetype plugin indent on')
vim.o.ai = true
vim.cmd('filetype indent on')
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.backspace = 'indent,eol,start'
vim.o.directory = '/tmp//'

-- Searching
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.magic = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false
vim.o.wildmenu = true
vim.o.wildignore = vim.o.wildignore .. ',bower_components,node_modules,tmp,dist,*.jpg,*.png,*.woff,*.eot,*.ttf'
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.suffixesadd = vim.o.suffixesadd .. '.js,.rb'
vim.o.scrolloff = 5
vim.wo.cursorline = true

-- Airline
vim.g.airline_theme = 'ayu_mirage'
vim.g.airline_section_x = ''
vim.g.airline_section_y = ''
if vim.fn.winwidth(0) > 80 then
  vim.g.airline_section_z = vim.fn['airline#section#create']({ 'windowswap', 'obsession', 'linenr', 'maxlinenr', ' :%3v' })
else
  vim.g.airline_section_z = vim.fn['airline#section#create']({ 'linenr', 'maxlinenr', ':%3v' })
end
vim.g['airline#extensions#tabline#enabled'] = 1

-- Indent Guides
vim.g.indentLine_color_term = 240
vim.g.indentLine_char = '⋮'
vim.g.indentLine_enabled = 1

-- FZF mappings
api.nvim_set_keymap('n', '<BS>', ':History<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<CR>', ':GFiles<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<S-Tab>', ':Files<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '<Leader><Tab>', ':GFiles?<CR>', { noremap = true, silent = true })

-- Autoformat mapping
api.nvim_set_keymap('n', '<C-a>', ':Autoformat<CR>', { noremap = true, silent = true })

-- textobject-ruby
vim.cmd('runtime macros/matchit.vim')

-- vim-vue
vim.g.vim_vue_plugin_load_full_syntax = 1

-- Autocommands
api.nvim_create_autocmd('BufWriteCmd', {
  pattern = '*',
  callback = write_and_trim_whitespace,
})

-- Cursor line & relative numbers group
local group = api.nvim_create_augroup('CursorLine', { clear = true })
api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = group,
  pattern = '*',
  callback = function()
    vim.wo.relativenumber = true
    vim.cmd('IndentLinesEnable')
  end,
})
api.nvim_create_autocmd('WinLeave', {
  group = group,
  pattern = '*',
  callback = function()
    vim.wo.relativenumber = false
    vim.cmd('IndentLinesDisable')
  end,
})

-- Colours / highlights
vim.cmd('highlight CursorlineNR cterm=bold term=bold ctermbg=white')
vim.cmd('highlight Cursorline cterm=none term=none')
vim.cmd('highlight ColorColumn ctermbg=236')
vim.cmd('highlight Search ctermbg=lightgreen')

-- Tweaks
api.nvim_create_autocmd('FileType', {
  pattern = 'xml',
  callback = function() vim.opt_local.equalprg = 'xmllint --format --recover - 2>/dev/null' end,
})
vim.o.t_Co = 256

-- Mappings
vim.g.mapleader = ' '
api.nvim_set_keymap('i', '<tab>', '<c-p>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>bp', "jIrequire'pry';binding.pry<CR><esc>:w<CR>", { noremap = true, silent = true })

-- Paste and indent properly
api.nvim_set_keymap('n', 'p', "mpp=`]`p", { noremap = true })
api.nvim_set_keymap('n', 'P', "mpP=`]`p", { noremap = true })
api.nvim_set_keymap('n', '<c-p>', 'p', { noremap = true })

-- Pane switching
api.nvim_set_keymap('n', '<c-l>', '<c-w><c-l>', { noremap = true })
api.nvim_set_keymap('n', '<c-k>', '<c-w><c-k>', { noremap = true })
api.nvim_set_keymap('n', '<c-j>', '<c-w><c-j>', { noremap = true })
api.nvim_set_keymap('n', '<c-h>', '<c-w><c-h>', { noremap = true })

-- Buffer switching
api.nvim_set_keymap('n', '<c-left>', ':bp<CR>', { noremap = true })
api.nvim_set_keymap('n', '<c-right>', ':bn<CR>', { noremap = true })
