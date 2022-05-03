require("toggleterm").setup({
	open_mapping = [[<leader>t]],
	size = function(term)
		if term.direction == "horizontal" then
			return 25
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
})
