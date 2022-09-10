local opts = { noremap = true, silent = true }

-- nvim-tree
-- alt + n 键打开关闭tree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Telescope
-- 查找文件
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", opts)
-- 全局搜索
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", opts)

-- bufferline
-- 左右Tab切换
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)
-- 关闭
--"moll/vim-bbye"
-- "moll/vim-bbye" 关闭当前 buffer
vim.keymap.set("n", "<leader>bc", ":Bdelete!<CR>", opts)
vim.keymap.set("n", "<C-w>", ":Bdelete!<CR>", opts)
-- 关闭左/右侧标签页
vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
-- 关闭其他标签页
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opts)
-- 关闭选中标签页
vim.keymap.set("n", "<leader>bp", ":BufferLinePickClose<CR>", opts)
