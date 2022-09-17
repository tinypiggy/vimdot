-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local servers = {
	sumneko_lua = require("lsp.lang.lua"),
	cssls = require("lsp.lang.css"),
	html = require("lsp.lang.html"),
	jsonls = require("lsp.lang.json"),
	tsserver = require("lsp.lang.ts"),
	vuels = require("lsp.lang.vue"),
	emmet_ls = require("lsp.lang.emmet"),
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

local lspconfig = require("lspconfig")

for name, config in pairs(servers) do
	lspconfig[name].setup(config)
end
