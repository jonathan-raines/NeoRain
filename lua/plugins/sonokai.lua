local M = {
  'sainnhe/sonokai',
  priority = 1000,
  lazy = false
}

M.config = function()
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_transparent_background = 1
  vim.g.sonokai_better_performance = 1
  vim.g.sonokai_disable_terminal_colors = 1
  vim.g.sonokai_dim_inactive_windows = 1
end

return M
