-- luasnip setup
local luasnip = require("luasnip")

-- lspkind
local lspkind = require("lspkind")

local function luasnip_step()
	vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
	require("luasnip").config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	})
	require("luasnip.loaders.from_lua").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_snipmate").lazy_load()
end

luasnip_step()

lspkind.init({
	-- default: true
	-- with_text = true,
	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = "symbol_text",
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = "codicons",
	-- override preset symbols
	--
	-- default: {}
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

-- 为 cmp.lua 提供参数格式
local lsp_kind_formatting = {
	format = lspkind.cmp_format({
		mode = "symbol_text",
		--mode = 'symbol', -- show only symbol annotations

		maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		-- The function below will be called before any actual modifications from lspkind
		-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		before = function(entry, vim_item)
			-- Source 显示提示来源
			vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
			return vim_item
		end,
	}),
}

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	-- 使用lspkind-nvim显示类型图标
	formatting = lsp_kind_formatting,
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	-- 输入模式下是否更新提示，设置为true会影响性能
	update_in_insert = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local status, ident_blankline = pcall(require, "indent_blankline")
if not status then
	vim.notify("没有找到 indent_blankline")
	return
end

ident_blankline.setup({
	-- 空行占位
	space_char_blankline = " ",
	-- 用 treesitter 判断上下文
	show_current_context = true,
	show_current_context_start = true,
	context_patterns = {
		"class",
		"function",
		"method",
		"element",
		"^if",
		"^while",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
	},
	-- :echo &filetype
	filetype_exclude = {
		"dashboard",
		"packer",
		"terminal",
		"help",
		"log",
		"markdown",
		"TelescopePrompt",
		"lsp-installer",
		"lspinfo",
		"toggleterm",
	},
	-- 竖线样式
	-- char = '¦'
	-- char = '┆'
	-- char = '│'
	-- char = "⎸",
	char = "▏",
})
