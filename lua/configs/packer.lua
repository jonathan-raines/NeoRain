local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>pc'] = { '<cmd>PackerCompile profile=true<CR>', { desc = 'Compile' } },
    ['<leader>pi'] = { '<cmd>PackerInstall<CR>', { desc = 'Install' } },
    ['<leader>pl'] = { '<cmd>PackerStatus<CR>', { desc = 'Status' } },
    ['<leader>pp'] = { '<cmd>PackerProfile<CR>', { desc = 'Profile' } },
    ['<leader>ps'] = { '<cmd>PackerSync<CR>', { desc = 'Sync' } },
    ['<leader>pu'] = { '<cmd>PackerUpdate<CR>', { desc = 'Update' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

return M
