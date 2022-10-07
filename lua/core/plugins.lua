vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({
		"williamboman/mason.nvim",
	})

	-- nvim-tree
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
	-- treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("neovim/nvim-lspconfig")
	-- indent-blankline
	use("lukas-reineke/indent-blankline.nvim")

	-- 代码格式化
	-- use("mhartington/formatter.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	-- completion config
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-buffer")

	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugins
	-- 常见编程语言代码段
	use("rafamadriz/friendly-snippets")
	-- lspkind
	use("onsails/lspkind-nvim")
	-- json 增强
	use("b0o/schemastore.nvim")
	-- TypeScript 增强
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
	-- lua 增强
	use("folke/lua-dev.nvim")
	-- Comment
	use("numToStr/Comment.nvim")
	-- git
	use("lewis6991/gitsigns.nvim")
	-- telescope
	use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- telescope extensions
	use("LinArcX/telescope-env.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use({ "akinsho/toggleterm.nvim" })
	-- project
	use("ahmedkhalf/project.nvim")
	-- bufferline
	use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
	-- lualine
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
	use("arkav/lualine-lsp-progress")

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app &&npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	----------------------------------------------
	-- dap
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("Pocco81/DAPInstall.nvim")
	use("nvim-telescope/telescope-dap.nvim")
	use("jbyuki/one-small-step-for-vimkind")
	-- vimspector
	-- use("puremourning/vimspector")

	--------------------- colorschemes --------------------
	-- tokyonight
	use("folke/tokyonight.nvim")
	-- OceanicNext
	use("mhartington/oceanic-next")
	-- gruvbox
	use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
	-- zephyr 暂时不推荐，详见上边解释
	-- use("glepnir/zephyr-nvim")
	-- nord
	use("shaunsingh/nord.nvim")
	-- onedark
	use("ful1e5/onedark.nvim")
	-- nightfox
	use("EdenEast/nightfox.nvim")
	-------------------------------------------------------
end)
