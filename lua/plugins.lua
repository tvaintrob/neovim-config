-- install and manage plugins

local packer_bootstrap = nil
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local install_command = "git clone --depth 1 https://github.com/wbthomason/packer.nvim" .. install_path

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system(install_command)
end

local _lazy_load = function(events)
	return function(opts)
		if opts.module_name then
			opts.config = string.format(
				[[
        local ok, module = pcall(require, "%s")
        if ok and type(module) == 'table' then
            module.setup()
        end
      ]],
				opts.module_name
			)
		end

		opts.event = events
		return opts
	end
end

local on_buffer = _lazy_load({ "BufRead", "BufNew" })

return require("packer").startup({
	function(use)
		use "wbthomason/packer.nvim"
		use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

		-- lua ecosystem dependencies
		use({ "nvim-lua/plenary.nvim", module = "plenary" })

		-- vcs integrations
		use(on_buffer({ "kdheepak/lazygit.nvim" }))
		use(on_buffer({ "f-person/git-blame.nvim" }))

		-- visual plugins
		use({ "EdenEast/nightfox.nvim" })
		use({ "nvim-lualine/lualine.nvim" })
		use({ "muniftanjim/nui.nvim", module = "nui" })
		use({ "norcalli/nvim-colorizer.lua", config = [[require('colorizer').setup()]] })
		use(on_buffer({ "rcarriga/nvim-notify", module_name = "nv_visual.notify" }))
		use(on_buffer({ "stevearc/dressing.nvim", module_name = "nv_visual.dressing" }))
		use(on_buffer({ "kyazdani42/nvim-web-devicons" }))

		-- editor behavior
		use(on_buffer({ "tpope/vim-repeat" }))
		use(on_buffer({ "tpope/vim-surround" }))
		use(on_buffer({ "tpope/vim-sensible" }))
		use(on_buffer({ "tpope/vim-commentary" }))
		use(on_buffer({ "editorconfig/editorconfig-vim" }))
		use(on_buffer({ "luukvbaal/stabilize.nvim", module_name = "stabilize" }))
		use(on_buffer({ "akinsho/toggleterm.nvim", module_name = "nv_editor.toggleterm" }))
		use({ "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", config = [[require("nv_editor.neotree")]] })
		use(on_buffer({
			"nvim-telescope/telescope.nvim",
			module_name = "nv_editor.telescope",
			requires = { { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } },
		}))

		-- language support
		use(on_buffer({ "hashivim/vim-terraform" }))
		use(on_buffer({ "joosepalviste/nvim-ts-context-commentstring" }))
		use(on_buffer({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", module_name = "nv_visual.treesitter" }))

		-- LSP support
		use(on_buffer({ "williamboman/nvim-lsp-installer", module_name = "nv_lsp.lsp_installer" }))
		use(on_buffer({ "folke/trouble.nvim" }))
		use(on_buffer({ "b0o/schemastore.nvim" }))
		use(on_buffer({ "folke/lsp-colors.nvim" }))
		use(on_buffer({ "folke/lua-dev.nvim" }))

		use({
			"hrsh7th/nvim-cmp",
			config = [[require("nv_lsp.nvim_cmp")]],
			requires = {
				{ "hrsh7th/vim-vsnip" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-vsnip" },
				{ "hrsh7th/cmp-buffer" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-nvim-lua" },
				{ "hrsh7th/cmp-nvim-lsp-signature-help" },
				{ "onsails/lspkind-nvim" },
			},
		})

		use(on_buffer({ "neovim/nvim-lspconfig", module_name = "nv_lsp.lsp_config" }))
		use(on_buffer({ "jose-elias-alvarez/null-ls.nvim", module_name = "nv_lsp.null_ls" }))

		use({ "mfussenegger/nvim-dap" })
		use({ "rcarriga/nvim-dap-ui" })
		use({ "mfussenegger/nvim-dap-python" })

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
