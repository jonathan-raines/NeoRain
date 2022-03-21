local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>rr'] = '<Plug>RestNvim',
  ['<leader>rp'] = '<Plug>RestNvimPreview',
  ['<leader>rl'] = '<Plug>RestNvimLast',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  r = {
    name = 'Rest',
    r = { 'Run Request' },
    l = { 'Run Last Request' },
    p = { 'Preview Request' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
