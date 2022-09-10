-- init lsp-installer mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- load modules
require("lsp.setup")

require("lsp.nvim-completion")

require("lsp.nvim-formatting")
