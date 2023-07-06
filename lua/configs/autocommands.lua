local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local misc = augroup('Misc', { clear = true })

autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  pattern = '*',
  command = 'silent! normal! g`"zv',
  group = misc
})

autocmd('TextYankPost', {
  desc = 'Highland text on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end,
  group = misc
})

autocmd('BufEnter', {
  desc = 'No commenting new line',
  pattern = '*',
  callback = function()
    vim.opt.fo:remove { 'c', 'r', 'o' }
  end,
  group = misc
})

autocmd('BufWritePre', {
  desc = 'Trim whitespace on save',
  pattern = '*',
  command = [[:%s/\s\+$//e]],
  group = misc
})

autocmd('Colorscheme', {
  desc = 'Set highlights for Statusline',
  pattern = '*',
  callback = function()
    require 'configs.statusline.colors'.set_hl()
  end,
  group = misc
})
