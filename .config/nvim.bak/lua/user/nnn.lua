local function copy_to_clipboard(lines)
	local joined_lines = table.concat(lines, "\n")
	vim.fn.setreg("+", joined_lines)
end

require("nnn").setup({
	command = "nnn -o -C",
	set_default_mappings = 0,
	replace_netrw = 1,
  layout = {
    left = '~20%',
  },
	action = {
		["<C-t>"] = "tab split",
		["<C-s>"] = "split",
		["<C-v>"] = "vsplit",
		["<C-o>"] = copy_to_clipboard,
	},
})
