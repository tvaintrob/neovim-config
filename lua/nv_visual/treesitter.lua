local treesitter = require "nvim-treesitter.configs"

treesitter.setup({
	ensure_installed = "all",
	ignore_install = { "haskell" },
	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	context_commentstring = { enable = true },
})
