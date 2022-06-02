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
  -- Alternate file
  ['<leader><space>'] = '<c-^>',

  -- Write / Quit
  ['<leader>w'] = '<cmd>up<CR>',
  ['<leader>q'] = 'ZZ',
  ['<leader>c'] = '<cmd>execute (v:count > 0 ? v:count : "") . "bd!"<CR>',
  ['<leader>C'] = '<cmd>%bd|e#|bd#<CR>',

  -- Keeping it centered
  ['J'] = 'mzJ`z',
  ['n'] = 'nzzzv',
  ['N'] = 'Nzzzv',

  -- Quickfix Navigation
  [']q'] = '<cmd>execute (v:count > 1 ? v:count : 1) . "cnext"<CR>',
  ['[q'] = '<cmd>execute (v:count > 1 ? v:count : 1) . "cprevious"<CR>',

  -- Buffer Navigation
  ['<Backspace>'] = '<cmd>bp<CR>',
  ['<Tab>'] = '<cmd>bn<CR>',

  -- Indent
  ['<'] = '<<',
  ['>'] = '>>',

  -- Add / Subtract
  ['+'] = '<C-a>',
  ['-'] = '<C-x>',

  -- Move Windows Around
  ['<C-h>'] = '<C-w>h',
  ['<C-l>'] = '<C-w>l',
  ['<C-j>'] = '<C-w>j',
  ['<C-k>'] = '<C-w>k',

  -- Move Lines Around
  ['<A-j>'] = ':m .+1<CR>==',
  ['<A-k>'] = ':m .-2<CR>==',

  -- Quickfix
  ['<C-q>'] = "<cmd>lua require('utils').quick_fix_toggle()<CR>",

  -- Resize windows
  ['<C-Up>'] = ':resize -5<CR>',
  ['<C-Down>'] = ':resize +5<CR>',
  ['<C-Left>'] = ':vertical resize -5<CR>',
  ['<C-Right>'] = ':vertical resize +5<CR>',
}

local insert_keymaps = {
  -- Escape closing character
  ['<A-l>'] = "<cmd>lua require('utils').escape_pair()<CR>",

  -- save in insert mode
  ['<C-s>'] = '<ESC>:up<CR>',
}

local visual_keymaps = {
  -- Move Lines Around
  ['<A-j>'] = ":m '>+1<CR>gv-gv",
  ['<A-k>'] = ":m '<-2<CR>gv-gv",

  -- Better Indenting
  ['<'] = '<gv',
  ['>'] = '>gv',
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
for key, cmd in pairs(normal_keymaps) do
  keymap('n', key, cmd, opts)
end

-- Map Insert Mode
for key, cmd in pairs(insert_keymaps) do
  keymap('i', key, cmd, opts)
end

-- Map Visual Mode
for key, cmd in pairs(visual_keymaps) do
  keymap('v', key, cmd, opts)
end

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

if vim.opt.diff:get() == true then
  keymap('n', '<C-f>', '<cmd>diffget LOCAL<CR>', opts)
  keymap('n', '<C-j>', '<cmd>diffget REMOTE<CR>', opts)
  keymap('n', '<leader>w', '<cmd>wqa<CR>', opts)
end
