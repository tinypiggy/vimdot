local function config_dapi_and_sign()
	local dap_breakpoint = {
		error = {
			text = "🛑",
			texthl = "LspDiagnosticsSignError",
			linehl = "",
			numhl = "",
		},
		rejected = {
			text = "",
			texthl = "LspDiagnosticsSignHint",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = "⭐️",
			texthl = "LspDiagnosticsSignInformation",
			linehl = "DiagnosticUnderlineInfo",
			numhl = "LspDiagnosticsSignInformation",
		},
	}

	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function config_dapui()
	local dap, dapui = require("dap"), require("dapui")

	local debug_open = function()
		dapui.open()
		vim.api.nvim_command("DapVirtualTextEnable")
	end
	local debug_close = function()
		dap.repl.close()
		dapui.close()
		vim.api.nvim_command("DapVirtualTextDisable")
		-- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
	end

	dap.listeners.after.event_initialized["dapui_config"] = function()
		debug_open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		debug_close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		debug_close()
	end
	dap.listeners.before.disconnect["dapui_config"] = function()
		debug_close()
	end
end

local function config_debuggers()
	local dap = require("dap")
	-- TODO: wait dap-ui for fixing temrinal layout
	-- the "30" of "30vsplit: doesn't work
	dap.defaults.fallback.terminal_win_cmd = "30vsplit new" -- this will be overrided by dapui
	dap.set_log_level("DEBUG")

	-- load from json file
	require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "cpp" } })
	-- require("user.dap.dap-cpp")
	-- require("user.dap.di-go")

	-- require("config.dap.python").setup()
	-- require("config.dap.rust").setup()
	-- require("config.dap.go").setup()
end

require("nvim-dap-virtual-text").setup({
	enabled = true, -- enable this plugin (the default)
	enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true, -- show stop reason when stopped for exceptions
	commented = false, -- prefix virtual text with comment string
	-- experimental features:
	virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
	all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
	virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

require("dap-ui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "o", "<2-LeftMouse>", "<CR>" },
		open = "O",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	sidebar = {
		-- You can change the order of elements in the sidebar
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			{
				id = "scopes",
				size = 0.35, -- Can be float or integer > 1
			},
			{ id = "stacks", size = 0.35 },
			{ id = "watches", size = 0.15 },
			{ id = "breakpoints", size = 0.15 },
		},
		size = 40,
		position = "left", -- Can be "left", "right", "top", "bottom"
	},
	tray = {
		elements = { "repl" },
		size = 5,
		position = "bottom", -- Can be "left", "right", "top", "bottom"
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

config_dapi_and_sign()
config_dapui()
config_debuggers()

require("debug.lua").setup()
require("debug.cpp")
