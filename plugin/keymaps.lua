local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --
local normal_keymaps = {
  ['<leader><space>'] = { '<c-^>', { desc = 'Alternate Buffer' } },

  ['<leader>w'] = { '<cmd>up<CR>', { desc = 'Write' } },
  ['<leader>q'] = { 'ZZ', { desc = 'Quit' } },
  ['<leader>c'] = { '<cmd>execute (v:count > 0 ? v:count : "") . "bd!"<CR>', { desc = 'Close Buffer' } },
  ['<leader>C'] = { '<cmd>%bd|e#|bd#<CR>', { desc = 'Close All But Current Buffer' } },

  ['J'] = { 'mzJ`z', { desc = 'Join on same line' } },
  ['n'] = { 'nzzzv', { desc = 'Center on next' } },
  ['N'] = { 'Nzzzv', { desc = 'Center on previous' } },

  ['<Backspace>'] = { '<cmd>bp<CR>', { desc = 'Previous Buffer' } },
  ['<Tab>'] = { '<cmd>bn<CR>', { desc = 'Next Buffer' } },

  ['<'] = { '<<', { desc = 'Increase Indent' } },
  ['>'] = { '>>', { desc = 'Decrease Indent' } },

  ['<C-h>'] = { '<C-w>h', { desc = 'Move to left window' } },
  ['<C-l>'] = { '<C-w>l', { desc = 'Move to right window' } },

  ['<C-j>'] = { ':m .+1<CR>==', { desc = 'Move line up' } },
  ['<C-k>'] = { ':m .-2<CR>==', { desc = 'Move line down' } },

  ['<C-q>'] = { "<cmd>lua require('utils').quick_fix_toggle()<CR>", { desc = 'QuickFix Toggle' } },
  [']q'] = { '<cmd>execute (v:count > 1 ? v:count : 1) . "cnext"<CR>', { desc = 'Next QuickFix Item' } },
  ['[q'] = { '<cmd>execute (v:count > 1 ? v:count : 1) . "cprevious"<CR>', { desc = 'Previous QuickFix Item' } },

  ['<C-Up>'] = { ':resize -5<CR>', { desc = 'Increase height of horizontal window' } },
  ['<C-Down>'] = { ':resize +5<CR>', { desc = 'Decrease height of horizontal window' } },
  ['<C-Left>'] = { ':vertical resize -5<CR>', { desc = 'Decrease width of vertical window' } },
  ['<C-Right>'] = { ':vertical resize +5<CR>', { desc = 'Increase width of vertical window' } },
}

local insert_keymaps = {
  ['<C-l>'] = { "<cmd>lua require('utils').escape_pair()<CR>", { desc = 'Escape pair' } },
}

local visual_keymaps = {
  -- Move Lines Around
  ['<C-j>'] = { ":m '>+1<CR>gv-gv", { desc = 'Move line up' } },
  ['<C-k>'] = { ":m '<-2<CR>gv-gv", { desc = 'Move line down' } },

  -- Better Indenting
  ['<'] = { '<gv', { desc = 'Keep visual selection on indent decrease' } },
  ['>'] = { '>gv', { desc = 'Keep visual selection on indent increase' } },
}

-- Center navigation commands
local navigation = { '{', '}', '<C-o>', '<C-i>', '<C-d>', '<C-u>', '<C-f>', '<C-b>', '*', '#' }
for _, char in ipairs(navigation) do
  keymap('n', char, char .. 'zz')
end

-- Undo break points
local break_points = { ',', '.', ';' }
for _, char in ipairs(break_points) do
  keymap('i', char, char .. '<C-g>u')
end

-- Map Normal Mode
for key, val in pairs(normal_keymaps) do
  keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
end

-- Map Insert Mode
for key, val in pairs(insert_keymaps) do
  keymap('i', key, val[1], vim.tbl_extend('keep', opts, val[2]))
end

-- Map Visual Mode
for key, val in pairs(visual_keymaps) do
  keymap('v', key, val[1], vim.tbl_extend('keep', opts, val[2]))
end

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

if vim.opt.diff:get() == true then
  keymap('n', '<C-f>', '<cmd>diffget LOCAL<CR>', opts)
  keymap('n', '<C-j>', '<cmd>diffget REMOTE<CR>', opts)
  keymap('n', '<leader>w', '<cmd>wqa<CR>', opts)
end
