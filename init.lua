require 'plugins'
require 'lsp'
require 'options'
require 'keymaps'

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]
vim.cmd [[ autocmd BufWinEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufNewFile * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]]
vim.cmd [[ autocmd BufWinEnter NvimTree set colorcolumn=0 nocursorcolumn ]]
vim.cmd [[ command BufOnly silent! execute "%bd|e#|bd#" ]]

-- Disable various builtin plugins in Vim that bog down speed
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1
