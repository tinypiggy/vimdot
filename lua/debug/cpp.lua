local dap = require("dap")

dap.adapters.codelldb = {
	type = "127.0.0.1",
	port = "13000",
	executable = {
		-- CHANGE THIS to your path!
		command = "/home/liuke/.local/share/nvim/mason/bin/codelldb",
		args = { "--port", "13000" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
