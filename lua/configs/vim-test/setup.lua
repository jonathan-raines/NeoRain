local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>tf'] = '<cmd>TestFile<CR>',
  ['<leader>tl'] = '<cmd>TestLast<CR>',
  ['<leader>tn'] = '<cmd>TestNearest<CR>',
  ['<leader>ts'] = '<cmd>TestSuite<CR>',
  ['<leader>tv'] = '<cmd>TestVisit<CR>',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  t = {
    name = 'Testing',
    f = { 'Run Test File' },
    l = { 'Run Last Test' },
    n = { 'Run Nearest Test' },
    s = { 'Run Test Suite' },
    v = { 'Visit Test File' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
