local ts_utils = require("nvim-lsp-ts-utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local flags = {
	debounce_text_changes = 150,
}

return {
	flags = flags,
	capabilities = capabilities,
	init_options = {
		hostInfo = "neovim",
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},

		on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			local bufopts = { noremap = true, silent = true, buffer = bufnr }

			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = false,

				import_all_timeout = 5000,

				import_all_priorities = {
					same_file = 1,
					local_files = 2,
					buffer_content = 3,
					buffers = 4,
				},

				import_all_scan_buffers = 100,
				import_all_select_source = false,

				always_orianize_imports = true,

				filter_out_diagnostics_by_serverity = {},

				filter_out_diagnostics_by_code = {
					80001,
				},

				auto_inlay_hints = true,
				inlay_hints_highlight = "Comment",
				inlay_hints_priority = 200,
				inlay_hints_throttle = 150,
				inlay_hints_format = {
					Type = {},
					Parameter = {},
					Emun = {},
				},

				update_imports_on_move = false,
				require_confirmation_on_move = false,
				watch_dir = nil,
			})

			ts_utils.setup_client(client)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		end,
	},
}
