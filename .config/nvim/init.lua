-- Plugins {{{
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'terrortylor/nvim-comment'
  use 'windwp/nvim-autopairs'
  use 'marko-cerovac/material.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use "akinsho/toggleterm.nvim"
  use 'lewis6991/impatient.nvim'
  use 'neovim/nvim-lspconfig'
  use 'akinsho/bufferline.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'andweeb/presence.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/luasnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'mhinz/vim-startify'
  use 'vimwiki/vimwiki'
  use 'mhartington/formatter.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'nvim-lualine/lualine.nvim'
  config = {
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
-- }}}

-- Starting some plugins {{{
vim.cmd[[autocmd FileType c,cpp lua require "c-ide"]]

require("packer.compile")

require('bufferline').setup {
  options = {
    numbers = "ordinal",
    offsets = {{filetype = "NvimTree", text = "NvimTree" , text_align = "left" }},
  }
}

require("presence"):setup({
    auto_update         = true,
    neovim_image_text   = "Neovim > Emacs",
    main_image          = "file",
    debounce_timeout    = 20, 
    enable_line_number  = true,
    buttons = {
      {
        label = "my init.lua" ,
       url = "https://github.com/iamchokerman/dotfiles/tree/main/.config/nvim"
      }
    }
})

require("toggleterm").setup({
  open_mapping = [[<c-o>]],
  direction = 'float',
  shell = "zsh",
})

vim.g.nvim_tree_width = 25
require'nvim-tree'.setup {auto_open = 1, auto_close = 1, gitignore = 1}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "startify" , "NvimTree", "packer" , "zsh" }
}

require('nvim_comment').setup({comment_empty = false})

require'nvim-autopairs'.setup{check_ts = true}

require('lualine').setup{
    extensions = {'nvim-tree','toggleterm'},
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c" , "lua" , "vim" , "bash" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
-- }}}

-- Setting some keybindings {{{
local keymap = vim.api.nvim_set_keymap
keymap('n', '<c-f>', ':NvimTreeFindFileToggle<cr>' , {silent = true})
vim.cmd([[
let mapleader =","
inoremap jj <Esc>
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

nnoremap S :%s//g<Left><Left>
nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sc :SClose<CR>
nnoremap <leader>sd :SDelete<CR>
nnoremap <leader>sl :SLoad<CR>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <space> :
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

map Q gq
map <leader>s :!clear && shellcheck -x %<CR>
map <leader>c :w! \| !compiler "<c-r>%"<CR>
nmap <leader>y :History:<CR>

" Custom commands
command -nargs=* Rename %s/tmp/\=printf('<args>_%03d', line('.'))/
command -bar Minus %s/_-_/-/g
command -bar Spaces %s/\ /_/g
command -bar Minus3 %s/___/_/g
command -bar Underminus %s/_-/-/g
command -bar Underdot %s/_\././g
command -bar Square %norm 0f[lda]
command -bar Cleanup :Spaces | :Minus | :Square | :Minus3 | :Underminus | :Underdot

]])
-- }}}

-- Some basic settings {{{
vim.cmd[[autocmd FileType startify f Startify]]
vim.cmd('filetype plugin indent on')
vim.o.swapfile = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.backup = false
vim.o.cursorline = true
vim.o.autochdir = true
vim.o.ignorecase = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.splitbelow = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.mouse = 'a'
vim.o.cmdheight = 2
vim.o.expandtab = true
vim.o.showmode = false
vim.o.shell = '/bin/dash'
vim.o.scrolloff = 999
vim.g["mapleader"] = ","
vim.o.autoread = true
-- }}}

-- Colorscheme config {{{
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_sidebars = {"qf", "vista_kind", "terminal", "packer"}
vim.g.tokyonight_colors = {hint = "orange", error = "#ff0000"}
vim.cmd('colorscheme tokyonight')
-- }}}

-- Startify config {{{
vim.api.nvim_command([[
highlight StartifyHeader  ctermfg=114
let g:startify_bookmarks = [ { 'c' : '~/.zshrc'} , { 's' : '~/.config/nvim/init.lua'} , { 'd' : ''} , { 'b' : '~/.local/bin'} , { 'a' : '~/dev/ani-cli/ani-cli'} , { 'v' : ''} ]
let g:startify_lists = [{ 'header': ['     Recent'],'type': 'files' },{ 'header': ['     Bookmarks'],'type': 'bookmarks' },]
let g:startify_custom_header ='startify#center(startify#fortune#cowsay())'
hi StartifyPath ctermbg=None ctermfg=Blue
nnoremap <silent> <C-e> :Startify<cr>
let g:startify_update_oldfiles = 1
let g:startify_fortune_use_unicode = 1
let g:startify_files_number = 5
let g:startify_padding_left = 5
autocmd TabNewEntered * Startify
]])
-- }}}

-- Vimwiki config {{{
vim.api.nvim_command([[
let g:vimwiki_list = [{'path': '~/stuff/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
]])
-- }}}

-- Autocommands{{{
vim.api.nvim_command([[
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
]])
-- }}}

-- vim:foldmethod=marker
