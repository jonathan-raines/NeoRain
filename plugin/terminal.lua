-- Augroups ==================================================================
local terminal_open_augroup = vim.api.nvim_create_augroup('Terminal Open', { clear = true })

-- Autocmds ===================================================================
vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Remove all visual effects for full screen terminal and start in insert mode',
  group = terminal_open_augroup,
  pattern = '*',
  callback = function()
    vim.cmd [[setlocal nonumber norelativenumber nobuflisted signcolumn=no]]
    vim.cmd [[set ft=terminal]]
  end
})
