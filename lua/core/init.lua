local fn = vim.fn

-- auto install plugins manager -> packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- load modules
require("core.basic")
require("core.plugins")
require("core.side-tree")
require("core.treesitter")
require("lsp")
