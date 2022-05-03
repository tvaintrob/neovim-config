local null_ls = require "null-ls"

null_ls.setup({
	debug = true,
	sources = {
    null_ls.builtins.code_actions.eslint_d,

    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.shellcheck,

		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.eslint_d,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.black.with({ args = { "-" } }),
	},
})

vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", { noremap = true, silent = true })
