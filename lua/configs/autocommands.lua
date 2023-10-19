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
  desc = 'Remove all visual effects for full screen terminal',
  group = terminal_augroup,
  pattern = '*',
  command = "setlocal nonumber norelativenumber nobuflisted signcolumn=no"
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Start terminal in insert mode',
  group = terminal_augroup,
  pattern = '*',
  command = "startinsert"
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = 'Close terminal when exits 0',
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    vim.cmd("bdelete")
  end
})

-- Do not comment on new line
-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = misc_augroup,
--   pattern = '*',
--   callback = function()
--     vim.opt.fo:remove { 'c', 'r', 'o' }
--   end
-- })

