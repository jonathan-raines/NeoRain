-- Augroups ==================================================================
local last_position_augroup = vim.api.nvim_create_augroup('Last Edit Position', { clear = true })
local yank_augroup = vim.api.nvim_create_augroup('Yank', { clear = true })

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
