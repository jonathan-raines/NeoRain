local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>gn'] = "<cmd>lua require('github-notifications.menu').notifications()<CR>",
  }

  for key, cmd in pairs(keymaps) do
    keymap('n', key, cmd, opts)
  end

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    local mappings = {
      g = {
        name = 'Git',
        n = { 'Github Notifications' },
      },
    }

    wk.register(mappings, { prefix = '<leader>' })
  end
end

M.config = function()
  local secrets = require 'secrets'

  require 'github-notifications'.setup {
    username = secrets.username,
    token = secrets.token,
  }
end

return M
