require('code_runner').setup({
  mode = 'toggleterm',
  filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    sh = "sh",
	},
	-- filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
	-- project_path = vim.fn.expand('~/.config/nvim/project_manager.json')
})

