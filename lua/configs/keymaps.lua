local keymap = vim.keymap.set
local opts = { silent = true }

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', '<Space>', '<Nop>', opts)

local keymaps = {
  { 'n', '<leader>w', vim.cmd.update,                                          { desc = 'Write' } },
  { 'n', '<leader>q', 'ZZ',                                                    { desc = 'Quit' } },
  { 'n', '<leader>c', '<cmd>execute (v:count > 0 ? v:count : "") . "bd!"<CR>', { desc = 'Close Buffer' } },
  { 'n', '<leader>C', require 'utils'.close_other_buffers,                     { desc = 'Close Other Buffers' } },
  { 'n', 'J',         'mzJ`z',                                                 { desc = 'Join on same line' } },
  { 'n', '<C-j>',     ':m .+1<CR>==',                                          { desc = 'Move line up' } },
  { 'n', '<C-k>',     ':m .-2<CR>==',                                          { desc = 'Move line down' } },
  { 'v', '<C-j>',     ":m '>+1<CR>gv-gv",                                      { desc = 'Move line up' } },
  { 'v', '<C-k>',     ":m '<-2<CR>gv-gv",                                      { desc = 'Move line down' } },
  { 'v', '<',         '<gv',                                                   { desc = 'Keep visual sel indent dec' } },
  { 'v', '>',         '>gv',                                                   { desc = 'Keep visual sel indent inc' } },
  { 'v', 'p',         '"_dP',                                                  { desc = 'Paste without replacing' } },
  { 'n', '<C-q>',     "<cmd>lua require('utils').quickfix_toggle()<CR>",       { desc = 'QuickFix Toggle' } },
  { 'n', ']q',        '<cmd>cnext<CR>',                                        { desc = 'QuickFix Next Item' } },
  { 'n', '[q',        '<cmd>cprev<CR>',                                        { desc = 'QuickFix Previous Item' } },
  { 'i', '<C-l>',     require 'utils'.escape_pair,                             { desc = 'Escape pair' } },
  { 'i', '.',         '.<C-g>u',                                               { desc = 'Undo Break Point' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('keep', opts, val[4]))
end
