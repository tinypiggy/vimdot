
local opts = { noremap = true, silent = true }

-- nvim-tree
-- alt + n 键打开关闭tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
