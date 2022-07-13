local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>pc'] = { '<cmd>PackerCompile profile=true<CR>', { desc = 'PackerCompile' } },
    ['<leader>pi'] = { '<cmd>PackerInstall<CR>', { desc = 'PackerInstall' } },
    ['<leader>pl'] = { '<cmd>PackerStatus<CR>', { desc = 'PackerStatus' } },
    ['<leader>pp'] = { '<cmd>PackerProfile<CR>', { desc = 'PackerProfile' } },
    ['<leader>ps'] = { '<cmd>PackerSync<CR>', { desc = 'PackerSync' } },
    ['<leader>pu'] = { '<cmd>PackerUpdate<CR>', { desc = 'PackerUpdate' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

return M
