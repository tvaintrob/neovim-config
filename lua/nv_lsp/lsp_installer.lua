require("nvim-lsp-installer").setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"cssls",
		"dockerls",
		"gopls",
		"html",
		"jsonls",
		"pyright",
		"sumneko_lua",
		"terraformls",
		"tsserver",
		"yamlls",
	},
})
