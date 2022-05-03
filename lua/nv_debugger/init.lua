local dap = require "dap"
local dap_ui = require "dapui"
local dap_python = require "dap-python"

dap_python.setup "~/.config/nvim/.virtualenvs/debugpy/bin/python"
dap_python.test_runner = "pytest"

dap_ui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dap_ui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dap_ui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dap_ui.close()
end

local start_debug_session = function()
	-- start debugger
	dap.continue()

	vim.api.nvim_set_keymap("n", "n", "<cmd>DapStepOver<cr>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "s", "<cmd>DapStepInto<cr>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "c", "<cmd>DapContinue<cr>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "b", "<cmd>DapToggleBreakpoint<cr>", { noremap = true, silent = true })
end

local end_debug_session = function()
	-- stop debugger
	dap.terminate()
end

vim.api.nvim_create_user_command("StartDebugSession", start_debug_session, {})
vim.api.nvim_create_user_command("EndDebugSession", end_debug_session, {})
