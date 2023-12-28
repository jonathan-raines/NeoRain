-- Leader key =================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps ====================================================================
local utils = require 'utils'

local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local keymaps = {
  { 'n', 'J',          'mzJ`z',       { desc = 'Join on same line' } },
  { "n", "<leader>bd", "<cmd>bd<cr>", { desc = 'Delete Buffer' } },
  { "n", "<leader>bD",
    function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_get_option_value("buflisted", { buf = buf })
            and not vim.api.nvim_get_option_value("modified", { buf = buf })
            and buf ~= vim.api.nvim_get_current_buf() then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end, { desc = "Delete all listed buffers except current", silent = true }
  },
  { "n", "<leader>bu", vim.cmd.update,              { desc = 'Update' } },
  { "n", "<leader>L",  "<cmd>Lazy<cr>",             { desc = 'Lazy' } },
  { "n", "<leader>hl", "<cmd>terminal lazygit<cr>", { desc = 'Lazygit' } },
  { 'n', '<leader>xq', utils.quickfix_toggle,       { desc = 'Toggle quickfix list' } },
  { 'n', '<leader>xl', utils.locallist_toggle,      { desc = 'Toggle location list' } },
  { 'v', '<C-j>',      ":m '>+1<CR>gv=gv",          { desc = 'Move line up' } },
  { 'v', '<C-k>',      ":m '<-2<CR>gv=gv",          { desc = 'Move line down' } },
  { 'v', '<',          '<gv',                       { desc = 'Keep visual sel indent dec' } },
  { 'v', '>',          '>gv',                       { desc = 'Keep visual sel indent inc' } },
  { 'i', '.',          '.<C-g>u',                   { desc = 'Undo Break Point' } },
  { 'x', 'p',          [["_dP]],                    { desc = 'Paste without replacing' } },
}

for _, val in pairs(keymaps) do
  keymap(val[1], val[2], val[3], vim.tbl_extend('force', default_opts, val[4]))
end
