local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>b', '<CMD>JABSOpen<CR>', { desc = 'Buffers' })
end

M.config = function()
  -- (Optional) easy way to get Neovim current size.
  local ui = vim.api.nvim_list_uis()[1]

  require 'jabs'.setup {
    position = 'center', -- center, corner
    width = 80,
    height = 20,
    border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars)

    -- Options for preview window
    preview_position = 'left', -- top, bottom, left, right
    preview = {
      -- width = 40,
      -- height = 30,
      border = 'rounded', -- none, single, double, rounded, solid, shadow, (or an array or chars)
    },

    -- the options below are ignored when position = 'center'
    col = ui.width, -- Window appears on the right
    row = ui.height / 2, -- Window appears in the vertical middle
  }
end

return M
