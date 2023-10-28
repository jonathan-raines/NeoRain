require 'configs.options'
require 'configs.autocommands'
require 'configs.keymaps'
require 'configs.lazy'
require 'configs.winbar'
require 'configs.statusline'

vim.cmd [[
  augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  augroup END
]]

vim.cmd.colorscheme 'miss-dracula'
