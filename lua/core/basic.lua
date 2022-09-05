-- vim basic configuaration
-- config by lua script

vim.g.encoding = 'UTF-8'
vim.o.fileencoding = 'UTF-8'

vim.wo.number = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.wo.cursorline = true
vim.wo.signcolumn = 'yes'

vim.o.smarttab = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

vim.o.smartindent = true
vim.o.autoindent = true

-- vim.o.nobackup = true
-- vim.o.noswapfile = true
vim.o.autoread = true

-- vim.o.nocompatible = true

vim.o.mouse = 'a'

vim.api.nvim_create_user_command('Test', function() end, {
  nargs = 1,
  complete = function(ArgLead, CmdLine, CursorPos)
    return {
      'strawberry',
      'star',
      'stellar',
    }
  end,
})
