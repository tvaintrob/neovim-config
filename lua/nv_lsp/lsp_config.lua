local lsp_installer = require "nvim-lsp-installer"

local on_attach = function(client, bufnr)
	local set_keymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	set_keymap(bufnr, "n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

local setup_server = function(server)
	local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
	}

	local default_opts = {
		handlers = handlers,
		on_attach = on_attach,
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	}

	local server_overrides = {
		yamlls = { settings = { yaml = { schemas = { kubernetes = "*.yaml" } } } },
		jsonls = { settings = { json = { schemas = require("schemastore").json.schemas() } } },
    sumneko_lua = require("lua-dev").setup(default_opts),
		gopls = {
			on_attach = function(client, bufnr)
				client.resolved_capabilities.document_formatting = false
				on_attach(client, bufnr)
			end,
		},
	}

	local server_opts = vim.tbl_extend("force", default_opts, server_overrides[server.name] or {})

	server:setup(server_opts)
	vim.cmd [[ do User LspAttachBuffers ]]
end

lsp_installer.on_server_ready(setup_server)
