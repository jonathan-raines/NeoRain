local M = {}

M.setup = function()
  vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
  vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

  vim.api.nvim_create_user_command('Lazygit', function()
    require 'FTerm'.scratch { cmd = { 'lazygit' },
      border = 'rounded',
      dimensions = {
        height = 0.9,
        width = 0.9,
      }
    }
  end, { bang = true })

  vim.keymap.set('n', '<leader>hl', '<cmd>Lazygit<CR>', { silent = true, remap = true, desc = 'Lazygit' })
end

M.config = function()
  require 'FTerm'.setup {
    border = 'rounded',
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
  }
end

return M
