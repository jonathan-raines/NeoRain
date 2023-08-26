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
  desc = 'Highlight text on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
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

local terminal = augroup('Terminal', { clear = true })
autocmd('TermOpen', {
  desc = 'Set terminal keymaps',
  pattern = 'term://*',
  callback = function()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  end,
  group = terminal,
})

autocmd('TermOpen', {
  desc = 'Set terminal keymaps',
  pattern = '*',
  command = 'startinsert',
  group = terminal,
})
