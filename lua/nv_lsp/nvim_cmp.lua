local cmp = require "cmp"
local types = require "cmp.types"
local mapping = require "cmp.config.mapping"

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	formatting = {
		format = require("lspkind").cmp_format(),
	},

	window = {
		completion = cmp.config.window.bordered({ border = "single" }),
		documentation = cmp.config.window.bordered(),
	},

	mapping = mapping.preset.insert({
		["<C-Space>"] = mapping.complete(),
		["<C-e>"] = mapping.abort(),
		["<C-j>"] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<C-k>"] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { "i", "c" }),
		["<CR>"] = mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
	}),
})
