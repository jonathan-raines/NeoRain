local keymap = vim.keymap.set
local opts = { silent = true }

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', '<Space>', '<Nop>', opts)

local keymaps = {
  { 'n',          'J',         'mzJ`z',            { desc = 'Join on same line' } },
  { 'v',          '<C-j>',     ":m '>+1<CR>gv=gv", { desc = 'Move line up' } },
  { 'v',          '<C-k>',     ":m '<-2<CR>gv=gv", { desc = 'Move line down' } },
  { 'v',          '<',         '<gv',              { desc = 'Keep visual sel indent dec' } },
  { 'v',          '>',         '>gv',              { desc = 'Keep visual sel indent inc' } },
  { 'i',          '.',         '.<C-g>u',          { desc = 'Undo Break Point' } },
  { 'x',          'p',         [["_dP]],           { desc = 'Paste without replacing' } },
  { { "n", "v" }, "<leader>p", [["+p]],            { desc = "Paste System Clipboard Down" } },
  { { "n", "v" }, "<leader>P", [["+P]],            { desc = "Paste System Clipboard Up" } },
  { { "n", "v" }, "<leader>y", [["+y]],            { desc = "Copy System Clipboard" } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('keep', opts, val[4]))
end
