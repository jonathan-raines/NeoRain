-- Leader key =================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps ====================================================================
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local keymaps = {
  { 'n', 'J',          'mzJ`z',                                                   { desc = 'Join on same line' } },
  -- { "n", "<leader>bd", "<cmd>bd<cr>",                                          { desc = 'Close Buffer' } },
  { "n", "<leader>L",  "<cmd>Lazy<cr>",                                           { desc = 'Lazy' } },
  { "n", "<leader>hl", "<cmd>terminal lazygit<cr>",                               { desc = 'Lazygit' } },
  { "n", "<leader>hL", "<cmd>lua require('lazy.util').float_term('lazygit')<CR>", { desc = 'Lazygit' } },
  { "n", "<leader>u",  vim.cmd.update,                                            { desc = 'Update File' } },
  { 'n', '<C-q>',      require 'configs.utils'.quickfix_toggle,                   { desc = 'Move line up' } },
  { 'v', '<C-j>',      ":m '>+1<CR>gv=gv",                                        { desc = 'Move line up' } },
  { 'v', '<C-k>',      ":m '<-2<CR>gv=gv",                                        { desc = 'Move line down' } },
  { 'v', '<',          '<gv',                                                     { desc = 'Keep visual sel indent dec' } },
  { 'v', '>',          '>gv',                                                     { desc = 'Keep visual sel indent inc' } },
  { 'i', '.',          '.<C-g>u',                                                 { desc = 'Undo Break Point' } },
  { 'x', 'p',          [["_dP]],                                                  { desc = 'Paste without replacing' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('force', default_opts, val[4]))
end
