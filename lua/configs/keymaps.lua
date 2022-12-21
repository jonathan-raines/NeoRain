local keymap = vim.keymap.set
local opts = {}

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', '<Space>', '<Nop>', opts)

local keymaps = {
  { 'n', '<leader>w', vim.cmd.update, { desc = 'Write' } },
  { 'n', '<leader>q', 'ZZ', { desc = 'Quit' } },

  { 'n', '<leader>c', '<cmd>execute (v:count > 0 ? v:count : "") . "bd!"<CR>', { desc = 'Close Buffer' } },
  { 'n', '<leader>C', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close Other Buffers' } },

  { 'n', 'J', 'mzJ`z', { desc = 'Join on same line' } },

  { 'n', '<leader>j', '<cmd>tabnew | terminal<CR>', { desc = 'Terminal' } },

  { 'n', '<leader>fe',
    function()
      vim.cmd.Telescope 'file_browser'
    end, { desc = 'Neotree' } },

  { 'n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute word under cursor' } },

  { 'n', '<C-j>', ':m .+1<CR>==', { desc = 'Move line up' } },
  { 'n', '<C-k>', ':m .-2<CR>==', { desc = 'Move line down' } },

  { 'v', '<C-j>', ":m '>+1<CR>gv-gv", { desc = 'Move line up' } },
  { 'v', '<C-k>', ":m '<-2<CR>gv-gv", { desc = 'Move line down' } },

  { 'v', '<', '<gv', { desc = 'Keep visual selection on indent decrease' } },
  { 'v', '>', '>gv', { desc = 'Keep visual selection on indent increase' } },

  { 'v', 'p', '"_dP', { desc = 'Paste without replacing' } },

  { 'n', '<C-q>', require 'utils'.quickfix_toggle, { desc = 'QuickFix Toggle' } },
  { 'n', ']q', '<cmd>cnext<CR>', { desc = 'QuickFix Next Item' } },
  { 'n', '[q', '<cmd>cprev<CR>', { desc = 'QuickFix Previous Item' } },

  { 'i', '<C-l>', require 'utils'.escape_pair, { desc = 'Escape pair' } },

  { 'i', '.', '.<C-g>u', { desc = 'Undo Break Point' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('keep', opts, val[4]))
end

for i = 1, 4 do
  local lhs = '<leader>' .. i
  local rhs = i .. '<C-W>w'

  keymap('n', lhs, rhs, { desc = 'Move to Window ' .. i })
end
