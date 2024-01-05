-- Augroups ==================================================================
local last_position_augroup = vim.api.nvim_create_augroup('Last Edit Position', { clear = true })
local yank_augroup = vim.api.nvim_create_augroup('Yank', { clear = true })
local terminal_open_augroup = vim.api.nvim_create_augroup('Terminal Open', { clear = true })
local terminal_close_augroup = vim.api.nvim_create_augroup('Terminal Close', { clear = true })

-- Autocmds ===================================================================
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  group = last_position_augroup,
  pattern = '*',
  command = 'silent! normal! g`"zv'
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text on yank',
  group = yank_augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Remove all visual effects for full screen terminal and start in insert mode',
  group = terminal_open_augroup,
  pattern = '*',
  callback = function()
    vim.cmd [[startinsert]]
    vim.cmd [[setlocal nonumber norelativenumber nobuflisted signcolumn=no]]
    vim.cmd [[set ft=terminal]]
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = 'Close terminal when exits 0',
  group = terminal_close_augroup,
  pattern = '*',
  command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif"
})
