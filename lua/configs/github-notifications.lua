local M = {}

function M.setup()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>gn'] = "<cmd>lua require('github-notifications.menu').notifications()<CR>",
  }

  for key, cmd in pairs(keymaps) do
    keymap('n', key, cmd, opts)
  end

  local mappings = {
    g = {
      name = 'Git',
      n = { 'Github Notifications' },
    },
  }

  require('which-key').register(mappings, { prefix = '<leader>' })
end

function M.config()
  local secrets = require 'secrets'

  require('github-notifications').setup {
    username = secrets.username,
    token = secrets.token,
  }
end

return M
