local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', '<Space>', '<Nop>', opts)

local keymaps = {
  { { 'i', 'v' }, 'jk', '<ESC>', { desc = 'Return to normal mode' } },

  { { 'n' }, '<leader>w', '<cmd>up<CR>', { desc = 'Write' } },

  { { 'n' }, '<leader>q', 'ZQ', { desc = 'Quit' } },

  { { 'n' }, '<leader><space>', '<C-^>', { desc = 'Alternate Buffer' } },

  { { 'n' }, '<leader>c', '<cmd>execute (v:count > 0 ? v:count : "") . "bd!"<CR>', { desc = 'Close Buffer' } },

  { { 'n' }, '<leader>C', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close Other Buffers' } },

  { { 'n' }, 'J', 'mzJ`z', { desc = 'Join on same line' } },

  { { 'n' }, '<Backspace>', '<cmd>bp<CR>', { desc = 'Previous Buffer' } },
  { { 'n' }, '<Tab>', '<cmd>bn<CR>', { desc = 'Next Buffer' } },

  { { 'n' }, '<', '<<', { desc = 'Increase Indent' } },
  { { 'n' }, '>', '>>', { desc = 'Decrease Indent' } },

  { { 'v' }, '<', '<gv', { desc = 'Keep visual selection on indent decrease' } },
  { { 'v' }, '>', '>gv', { desc = 'Keep visual selection on indent increase' } },

  { { 'n' }, '<C-j>', ':m .+1<CR>==', { desc = 'Move line up' } },
  { { 'n' }, '<C-k>', ':m .-2<CR>==', { desc = 'Move line down' } },

  { { 'v' }, '<C-j>', ":m '>+1<CR>gv-gv", { desc = 'Move line up' } },
  { { 'v' }, '<C-k>', ":m '<-2<CR>gv-gv", { desc = 'Move line down' } },

  { { 'i' }, '<C-l>', "<cmd>lua require('utils').escape_pair()<CR>", { desc = 'Escape pair' } },

  { { 'n' }, '<C-q>', "<cmd>lua require('utils').quickfix_toggle()<CR>", { desc = 'QuickFix Toggle' } },
  { { 'n' }, ']q', '<cmd>cnext<CR>', { desc = 'QuickFix Next Item' } },
  { { 'n' }, '[q', '<cmd>cprevious<CR>', { desc = 'QuickFix Previous Item' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('keep', opts, val[4]))
end

-- Undo break points
local break_points = { ',', '.', ';' }
for _, char in ipairs(break_points) do
  keymap('i', char, char .. '<C-g>u')
end
