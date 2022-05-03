local neotree = require "neo-tree"

neotree.setup({
	close_if_last_window = true,
	default_component_configs = {
		indent = {
			padding = 1,
			indent_size = 4,
		},
	},
	window = {
		position = "float",
	},
	filesystem = {
		follow_current_file = true,
		window = {
			mappings = {
				["^"] = "navigate_up",
				["I"] = "toggle_hidden",
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "-", ":Neotree filesystem float reveal<cr>", { noremap = true, silent = true })
