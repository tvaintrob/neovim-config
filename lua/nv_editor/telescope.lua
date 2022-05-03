local telescope = require "telescope"
local telescope_actions = require "telescope.actions"

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = telescope_actions.close,
			},
		},
	},

	extensions = {
		fzf = {
			fuzzy = true,
			case_mode = "smart_case",
			override_file_sorter = true,
			override_generic_sorter = true,
		},
	},
})

telescope.load_extension "fzf"

vim.api.nvim_set_keymap(
	"n",
	"<c-p>",
	[[<cmd>lua require('nv_editor.telescope_extensions').project_files()<cr>]],
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<c-f>",
	[[<cmd>lua require('telescope.builtin').grep_string({ search = '' })<cr>]],
	{ noremap = true, silent = true }
)
