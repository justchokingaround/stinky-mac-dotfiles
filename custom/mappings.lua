local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
  }
}

-- Github Copilot Bindings
-----------------------------------------------------------
M.copilot = {
  mode_opts = { expr = true },
  i = {
    ["<C-h>"] = { 'copilot#Accept("<Left>")', "?   copilot accept" },
  },
}

M.abc = {
  n = {
    ["<leader>cc"] = { ":Telescope <CR>", "Toggle Telescope" },
    ["<leader>h"] = { ":noh<cr>", "noh" },
    ["S"] = { ":%s//gI<left><left><left>", "replace" },
    ["Y"] = { "y$" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
    ["J"] = { "mzJ`z" },

    -- Macros to compile and shi
    ["<leader>J"] = { ":!javac % && java %<cr>", "compile java" },
    ["<leader>P"] = { ":!python3 %<cr>", "compile python" },
    ["<leader>R"] = { ":!cargo run <cr>", "compile rust" },
    ["<leader>C"] = { ":!gcc % && ./a.out<cr>", "compile C" },
    ["<leader>G"] = { ":!gradle build && gradle run<cr>", "compile gradle" },
    ["<leader>ps"] = { ":PackerSync <CR>", "PackerSync" },
    },

}

return M
