local theme = require "nightfox"

theme.setup({
	options = {
		terminal_colors = false,
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})

vim.cmd [[ colorscheme nightfox ]]
