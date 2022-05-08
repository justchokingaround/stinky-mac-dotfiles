-- Plugins {{{
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'ibhagwan/fzf-lua'
  use 'terrortylor/nvim-comment'
  use 'windwp/nvim-autopairs'
	use 'junegunn/gv.vim'
	use 'tpope/vim-fugitive'
  use 'marko-cerovac/material.nvim'
	use 'Mofiqul/dracula.nvim'
  use "lukas-reineke/indent-blankline.nvim"
  use "akinsho/toggleterm.nvim"
  use 'lewis6991/impatient.nvim'
  use 'akinsho/bufferline.nvim'
  use 'andweeb/presence.nvim'
  use 'mhinz/vim-startify'
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
require("packer.compile")

require'lspconfig'.pyright.setup{}

require('lualine').setup {
  options = {
    theme = 'dracula-nvim'
  }
 }

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
        label = "Neovim > Emacs" ,
        url = "https://github.com/iamchokerman/dotfiles" 
      }
    }
})

require("toggleterm").setup({
  open_mapping = [[<c-o>]],
  direction = 'float',
  shell = "zsh",
})

vim.g.nvim_tree_width = 25
require'nvim-tree'.setup {
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "startify" , "NvimTree", "packer" , "toggleterm" }
}

require('nvim_comment').setup({comment_empty = false})

require'nvim-autopairs'.setup{check_ts = true}

require('lualine').setup{
    extensions = {'nvim-tree','toggleterm'},
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua" , "vim" , "bash" , "go" },
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
keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})
keymap('n', '<C-n>', '<C-w>n', {noremap = true, silent = true})
keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
keymap('n', '<C-w>q' , ':bdelete!<CR>' , {silent = true})
keymap("n", "<C-Up>", ":resize -2<CR>", {silent = true})
keymap("n", "<C-Down>", ":resize +2<CR>", {silent = true})
keymap("n", "<C-Left>", ":vertical resize -2<CR>", {silent = true})
keymap("n", "<C-Right>", ":vertical resize +2<CR>", {silent = true})
keymap("n", "<S-h>", ":BufferLineCyclePrev<cr>", {silent = true})
keymap("n", "<S-l>", ":BufferLineCycleNext<cr>", {silent = true})

vim.cmd([[
let mapleader =" "
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
nnoremap <silent> <leader>h :noh<cr>
nnoremap <silent> <leader>c :bd<cr>
nnoremap <C-s> = :w<cr>
nnoremap <silent> <leader>f :FzfLua<cr>
nnoremap <silent> <leader>w :FzfLua grep_cword<cr>
nnoremap <silent> <leader>s :FzfLua files<cr>
nnoremap <leader>ps :PackerSync<cr>
nnoremap <silent> <leader>e :NvimTreeFindFileToggle<cr>
nnoremap <silent> <leader>J :!javac % && java %<cr>
nnoremap <silent> <leader>P :!python3 %<cr>
nnoremap <silent> <leader>R :!cargo run<cr>
nnoremap <silent> <leader>C :!gcc % && ./a.out<cr>
nnoremap <silent> <leader>G :!gradle build && gradle run<cr>
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
map Q gq
" map <leader>c :w! \| !compiler "<c-r>%"<CR>
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
vim.o.showmode = false
vim.o.shell = '/bin/dash'
vim.o.scrolloff = 999
vim.g["mapleader"] = ","
vim.g.material_style = "darker"
vim.o.autoread = true
vim.opt.syntax = "ON"
vim.opt.termguicolors = true
-- }}}

-- Colorscheme config {{{
require('material').setup({
	italics = {comments = true},
	disable = {
		borders = true,
		background = true,
	},
	lualine_style = "stealth"
})
vim.cmd('colorscheme material')
-- vim.cmd('colorscheme dracula')
-- }}}

-- Startify config {{{
vim.api.nvim_command([[
highlight StartifyHeader  ctermfg=114
let g:startify_bookmarks = [ { 'c' : '~/dotfiles/.config/zsh/.zshrc'} , { 's' : '~/.config/nvim/init.lua'} , { 'd' : '~/.config/skhd/skhdrc'} , { 'b' : '~/.local/bin'} , { 'a' : '~/dev/ani-cli/ani-cli'} , { 'v' : ''} ]
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

-- Autocommands{{{
vim.api.nvim_command([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
]])
vim.cmd[[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]]
-- }}}

-- vim:foldmethod=marker

