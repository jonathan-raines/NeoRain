local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local misc = augroup('Misc', { clear = true })
local terminal = augroup('Terminal', { clear = true })

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

autocmd('Colorscheme', {
  desc = 'Set highlights for Statusline',
  pattern = '*',
  callback = function()
    require 'configs.statusline.colors'.set_hl()
  end,
  group = misc
})

autocmd('BufWritePre', {
  desc = 'Trim whitespace on save',
  pattern = '*',
  command = [[:%s/\s\+$//e]],
  group = misc
})

autocmd('BufRead', {
  desc = 'Set jbuilder filetype to ruby',
  pattern = '*.json.jbuilder',
  command = [[set ft=ruby]],
  group = misc
})

autocmd('TermClose', {
  desc = 'Close terminal with bd',
  pattern = '*',
  command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
  group = terminal
})

autocmd('TermOpen', {
  desc = 'Set terminal keymaps',
  pattern = 'term://*',
  command = "lua require('utils').set_terminal_keymaps()",
  group = terminal
})

autocmd('TermOpen', {
  desc = 'Set terminal options',
  pattern = '*',
  command = 'set nonumber norelativenumber nobuflisted',
  group = terminal
})

autocmd('TermOpen', {
  desc = 'Start terminal in insert mode',
  pattern = '*',
  command = 'startinsert',
  group = terminal
})
