local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>oic'] = '<cmd>Octo issue create<CR>',
  ['<leader>oil'] = '<cmd>Octo issue list<CR>',
  ['<leader>op'] = '<cmd>Octo pr list<CR>',
  ['<leader>ors'] = '<cmd>Octo review start<CR>',
  ['<leader>orf'] = '<cmd>Octo review submit<CR>',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { 'Create Issue' },
      l = { 'List Issues' },
    },
    p = { 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { 'Start Review' },
      f = { 'Submit Review' },
    },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
