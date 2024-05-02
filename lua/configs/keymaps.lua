-- Leader key =================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps ====================================================================
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local keymaps = {
  { 'n',          '<leader>bd', vim.cmd.bd,                                         { desc = 'Delete Buffer' } },
  { 'n',          '<leader>bu', vim.cmd.update,                                     { desc = 'Update' } },
  { 'n',          '<leader>e',  vim.cmd.Explore,                                    { desc = 'Netrw' } },
  { 'n',          '<leader>L',  vim.cmd.Lazy,                                       { desc = 'Lazy' } },
  { 'n',          '<leader>bD', [[:%bd|e#|bd#<cr>]],                                { desc = 'Delete all listed buffers except current' } },
  { 'n',          '<leader>hl', [[:tab terminal lazygit<CR>]],                      { desc = 'Lazygit' } },
  { 'n',          '<leader>S',  [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute under cursor', silent = false } },
  { 'n',          'J',          [[mzJ`z]],                                          { desc = 'Join on same line' } },
  { { 'n', 'v' }, '<leader>y',  [["+y]],                                            { desc = 'Copy to system clipboard' } },
  { { 'n', 'v' }, '<leader>Y',  [["+Y]],                                            { desc = 'Copy to system clipboard' } },
  { { 'n', 'v' }, '<leader>p',  [["+p]],                                            { desc = 'Paste from system clipboard' } },
  { { 'n', 'v' }, '<leader>P',  [["+P]],                                            { desc = 'Paste from system clipboard' } },
  { 'x',          'p',          [["_dP]],                                           { desc = 'Paste without replacing' } },
  { 'v',          '<C-j>',      [[:m '>+1<CR>gv=gv]],                               { desc = 'Move line up' } },
  { 'v',          '<C-k>',      [[:m '<-2<CR>gv=gv]],                               { desc = 'Move line down' } },
  { 'v',          '<',          [[<gv]],                                            { desc = 'Keep visual select indent decrease' } },
  { 'v',          '>',          [[>gv]],                                            { desc = 'Keep visual select indent increase' } },
  { 'i',          '.',          [[.<C-g>u]],                                        { desc = 'Undo Break Point' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('force', default_opts, val[4]))
end
