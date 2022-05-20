-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:
local userPlugins = require "custom.plugins"

M.options = {
        user = function()
                vim.g.copilot_no_tab_map = true
                vim.g.copilot_assume_mapped = true
                vim.g.copilot_tab_fallback = ""
                vim.opt.relativenumber = true
                -- saves cursor position for the next time you open the file
                vim.api.nvim_command([[
          autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
          autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
          ]]     )
        end,
}

M.ui = {
        -- hl_override = {
        --         Pmenu = { bg = "#ffffff" },
        -- },
        MyHighlightGroup = {
                fg = "abc",
                bg = "xyz"
        },
        changed_themes = {},
        colors = {}, -- dynamically generated, never edit this in chadrc
        theme_toggle = { "tokyonight", "tokyodark" },
        theme = "gruvbox", -- default theme
        transparency = true
}

M.mappings = require "custom.mappings"
M.plugins = {
  options = {
      lspconfig = {
        setup_lspconf = "custom.plugins.lspconfig",
      },
    },
  user = userPlugins,
}

return M
