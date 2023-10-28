-- Augroups ==================================================================
local misc_augroup = vim.api.nvim_create_augroup('Misc', { clear = true })
local terminal_augroup = vim.api.nvim_create_augroup('Terminal', { clear = true })

-- Autocmds ===================================================================
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Open file at the last position it was edited earlier',
  pattern = '*',
  command = 'silent! normal! g`"zv',
  group = misc_augroup
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight text on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual' }
  end,
  group = misc_augroup
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'Remove all visual effects for full screen terminal and start in insert mode',
  group = terminal_augroup,
  pattern = '*',
  callback = function()
    vim.cmd [[startinsert]]
    vim.cmd [[setlocal nonumber norelativenumber nobuflisted signcolumn=no]]
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = 'Close terminal when exits 0',
  group = terminal_augroup,
  pattern = '*',
  command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
})

vim.api.nvim_create_autocmd("Colorscheme", {
  desc = 'Set highlights for Statusline',
  pattern = '*',
  callback = function()
    local statusline_bg = '#1E1F29'
    local groups = {
      StatusLine = { fg = '#F6F6F5', bg = statusline_bg },

      StatuslineModeNormal = { fg = statusline_bg, bg = '#32CD32', bold = true },
      StatuslineModeSeparatorNormal = { fg = '#32CD32', bg = statusline_bg, bold = true },

      StatuslineModeInsert = { fg = statusline_bg, bg = '#FF7518', bold = true },
      StatuslineModeSeparatorInsert = { fg = '#FF7518', bg = statusline_bg, bold = true },

      StatuslineModeVisual = { fg = statusline_bg, bg = '#DA70D6', bold = true },
      StatuslineModeSeparatorVisual = { fg = '#DA70D6', bg = statusline_bg, bold = true },

      StatuslineModeReplace = { fg = statusline_bg, bg = '#D2042D', bold = true },
      StatuslineModeSeparatorReplace = { fg = '#D2042D', bg = statusline_bg, bold = true },

      StatuslineModeCommand = { fg = statusline_bg, bg = '#DFFF00', bold = true },
      StatuslineModeSeparatorCommand = { fg = '#DFFF00', bg = statusline_bg, bold = true },

      StatuslineModeTerminal = { fg = statusline_bg, bg = '#F4BB44', bold = true },
      StatuslineModeSeparatorTerminal = { fg = '#F4BB44', bg = statusline_bg, bold = true },

      StatuslineModeNTerminal = { fg = statusline_bg, bg = '#93C572', bold = true },
      StatuslineModeSeparatorNTerminal = { fg = '#93C572', bg = statusline_bg, bold = true },

      StatuslineModeSeparatorOther = { fg = '#FFBFA9', bold = true },
      StatuslineItalic = { fg = '#A9ABAC', bg = statusline_bg, italic = true },
      StatuslineSpinner = { fg = '#97EDA2', bg = statusline_bg, bold = true },
      StatuslineTitle = { fg = '#FFFFFF', bg = statusline_bg, bold = true },

      -- Winbar styling.
      WinBar = { fg = '#F6F6F5', bg = statusline_bg },
      WinBarSeparator = { fg = '#87E58E', bg = statusline_bg },
      WinBarSpecial = { fg = '#E7A1D7', bg = statusline_bg, italic = true },
    }

    for group, opts in pairs(groups) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
  group = vim.api.nvim_create_augroup('Statusline', { clear = true })
})
