local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>pc'] = '<cmd>PackerCompile<CR>',
  ['<leader>pi'] = '<cmd>PackerInstall<CR>',
  ['<leader>pl'] = '<cmd>PackerStatus<CR>',
  ['<leader>ps'] = '<cmd>PackerSync<CR>',
  ['<leader>pu'] = '<cmd>PackerUpdate<CR>',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  p = {
    name = 'Packer',
    c = { 'PackerCompile' },
    i = { 'PackerInstall' },
    l = { 'PackerStatus' },
    s = { 'PackerSync' },
    u = { 'PackerUpdate' },
  },
}

require('which-key').register(mappings, { prefix = '<leader>' })
