-- custom/plugins/init.lua

return {
        ["xiyaowong/accelerated-jk.nvim"] = {
          config = function()
            require "custom.plugins.accelerated-jk"
          end,
        },
        ["andweeb/presence.nvim"] = {},
        ["github/copilot.vim"] = {},
        ["nvim-telescope/telescope-media-files.nvim"] = {
                after = "telescope.nvim",
                config = function()
                        require("telescope").load_extension "media_files"
                end,
        },

        ["Pocco81/TrueZen.nvim"] = {
                cmd = {
                        "TZAtaraxis",
                        "TZMinimalist",
                        "TZFocus",
                },
                config = function()
                        require "custom.plugins.truezen"
                end,
        },
}
