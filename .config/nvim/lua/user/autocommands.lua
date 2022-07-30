-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

-- Launch Nvim with Transparent Background
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function ()
   -- vim.cmd ":TransparentEnable"
   vim.cmd ":TransparentDisable"
  end
})

-- Set transparency setting for Neovide
-- let g:neovide_transparency=0.95
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function ()
   vim.cmd ":let g:neovide_transparency=0.7"
  end
})

-- highlight Beacon guibg=white ctermbg=15
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function ()
   vim.cmd ":hi Beacon guibg=black ctermbg=12"
  end
})

-- lightspeed stuff
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function ()
   vim.cmd ":lua require'lightspeed'.init_highlight(true)"
  end
})

