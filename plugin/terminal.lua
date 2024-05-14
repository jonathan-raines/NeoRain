-- Augroups ==================================================================
local terminal_open_augroup = vim.api.nvim_create_augroup('Terminal Open', { clear = true })
local terminal_close_augroup = vim.api.nvim_create_augroup('Terminal Close', { clear = true })

-- Autocmds ===================================================================
vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Remove all visual effects for full screen terminal and start in insert mode',
  group = terminal_open_augroup,
  pattern = '*',
  callback = function()
    vim.cmd [[startinsert]]
    vim.cmd [[setlocal nonumber norelativenumber nobuflisted signcolumn=no]]
    vim.cmd [[set ft=terminal]]
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = 'Close terminal when exits 0',
  group = terminal_close_augroup,
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'fzf' then
      vim.cmd "close"
    end
  end
})

vim.keymap.set('n', '<leader>hl', [[:tab terminal lazygit<CR>]], { silent = true, desc = 'Lazygit' })
