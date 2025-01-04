--  ╭─────────────────────────────────────────────────────────╮
--  │                     Leader Key                          │
--  ╰─────────────────────────────────────────────────────────╯
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Keymaps                             │
--  ╰─────────────────────────────────────────────────────────╯
local keymaps = {
  { 'n',          '<leader>bd', vim.cmd.bd,                                                 { desc = 'Delete Buffer' } },
  { 'n',          '<leader>bq', [[:%bd|e#|bd#<cr>]],                                        { desc = 'Delete all listed buffers except current' } },
  { 'n',          '<leader>bu', vim.cmd.update,                                             { desc = 'Update' } },
  { 'n',          '<leader>s',  [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],         { desc = 'Substitute under cursor', silent = false } },
  { 'n',          'J',          [[mzJ`z]],                                                  { desc = 'Join on same line' } },
  { 'n',          'gy',         ":call setreg('+', expand('%:.'))<CR>",                     { desc = 'Copy current file path to clipboard' } },
  { 'n',          'gY',         ":call setreg('+', expand('%:.') .. ':' .. line('.'))<CR>", { desc = 'Copy current file path to clipboard' } },
  { { 'n', 'x' }, '<leader>y',  [["+y]],                                                    { desc = 'Copy to system clipboard' } },
  { { 'n', 'x' }, '<leader>p',  [["+p]],                                                    { desc = 'Paste from system clipboard' } },
  { { 'n', 'x' }, '<leader>P',  [["+P]],                                                    { desc = 'Paste from system clipboard' } },
  { 'x',          'p',          [["_dP]],                                                   { desc = 'Paste without replacing' } },
  { 'x',          '<C-j>',      [[:m '>+1<CR>gv=gv]],                                       { desc = 'Move line up' } },
  { 'x',          '<C-k>',      [[:m '<-2<CR>gv=gv]],                                       { desc = 'Move line down' } },
  { 'x',          '<',          [[<gv]],                                                    { desc = 'Keep visual select indent decrease' } },
  { 'x',          '>',          [[>gv]],                                                    { desc = 'Keep visual select indent increase' } },
  { 'i',          '.',          [[.<C-g>u]],                                                { desc = 'Undo Break Point' } },
}

for _, val in pairs(keymaps) do
  vim.keymap.set(val[1], val[2], val[3], vim.tbl_extend('force', {}, val[4]))
end
