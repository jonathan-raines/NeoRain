local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>pc'] = '<cmd>PackerCompile profile=true<CR>',
    ['<leader>pi'] = '<cmd>PackerInstall<CR>',
    ['<leader>pl'] = '<cmd>PackerStatus<CR>',
    ['<leader>pp'] = '<cmd>PackerProfile<CR>',
    ['<leader>ps'] = '<cmd>PackerSync<CR>',
    ['<leader>pu'] = '<cmd>PackerUpdate<CR>',
  }

  for key, cmd in pairs(keymaps) do
    keymap('n', key, cmd, opts)
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    local mappings = {
      p = {
        name = 'Packer',
        c = { 'PackerCompile' },
        i = { 'PackerInstall' },
        l = { 'PackerStatus' },
        p = { 'PackerProfile' },
        s = { 'PackerSync' },
        u = { 'PackerUpdate' },
      },
    }

    require 'which-key'.register(mappings, { prefix = '<leader>' })
  end
end

return M
