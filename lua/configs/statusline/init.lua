-- Don't show the command that produced the quickfix list.
vim.g.qf_disable_statusline = 1

-- Show the mode in my custom component instead.
vim.o.showmode = false

require 'configs.statusline.autocommands'

vim.o.statusline = "%!v:lua.require'configs.statusline.modules'.render()"
