-- vim basic configuaration
-- config by lua script

vim.o.encoding = 'UTF-8'

vim.o.number = true

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
