-- Augroups ==================================================================
local misc_augroup = vim.api.nvim_create_augroup('Misc', { clear = true })
local terminal_augroup = vim.api.nvim_create_augroup('Terminal', { clear = true })

-- Autocmds ===================================================================
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  pattern = '*',
  command = 'silent! normal! g`"zv',
  group = misc_augroup
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end,
  group = misc_augroup
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Remove all visual effects for full screen terminal and start in insert mode',
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    vim.cmd [[startinsert]]
    vim.cmd [[setlocal nonumber norelativenumber nobuflisted signcolumn=no]]
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = 'Close terminal when exits 0',
  group = terminal_augroup,
  pattern = '*',
  command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
})

vim.api.nvim_create_autocmd("Colorscheme", {
  desc = 'Set highlights for Statusline',
  pattern = '*',
  callback = function()
    require 'configs.statusline.colors'.set_hl()
  end,
  group = vim.api.nvim_create_augroup('Statusline', { clear = true })
})
