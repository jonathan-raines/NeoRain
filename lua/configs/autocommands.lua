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
    vim.cmd [[set ft=terminal]]
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
    _G_statusline_hls = {}

    local fg_hl = vim.api.nvim_get_hl(0, { name = '@keyword', link = false })
    local sl_bg = '#1E1F29'

    local groups = {
      StatusLine = { fg = '#F6F6F5', bg = sl_bg },

      StatuslineModeNormal = { fg = sl_bg, bg = '#32CD32', bold = true },
      StatuslineModeSeparatorNormal = { fg = '#32CD32', bg = sl_bg, bold = true },

      StatuslineModeInsert = { fg = sl_bg, bg = '#FF7518', bold = true },
      StatuslineModeSeparatorInsert = { fg = '#FF7518', bg = sl_bg, bold = true },

      StatuslineModeVisual = { fg = sl_bg, bg = '#DA70D6', bold = true },
      StatuslineModeSeparatorVisual = { fg = '#DA70D6', bg = sl_bg, bold = true },

      StatuslineModeReplace = { fg = sl_bg, bg = '#D2042D', bold = true },
      StatuslineModeSeparatorReplace = { fg = '#D2042D', bg = sl_bg, bold = true },

      StatuslineModeCommand = { fg = sl_bg, bg = '#DFFF00', bold = true },
      StatuslineModeSeparatorCommand = { fg = '#DFFF00', bg = sl_bg, bold = true },

      StatuslineModeTerminal = { fg = sl_bg, bg = '#F4BB44', bold = true },
      StatuslineModeSeparatorTerminal = { fg = '#F4BB44', bg = sl_bg, bold = true },

      StatuslineModeNTerminal = { fg = sl_bg, bg = '#93C572', bold = true },
      StatuslineModeSeparatorNTerminal = { fg = '#93C572', bg = sl_bg, bold = true },

      StatuslineModeSeparatorOther = { fg = '#FFBFA9', bg = sl_bg, bold = true },
      StatuslineItalic = { fg = '#A9ABAC', bg = sl_bg, italic = true },
      StatuslineSpinner = { fg = '#97EDA2', bg = sl_bg, bold = true },
      StatuslineTitle = { fg = '#FFFFFF', bg = sl_bg, bold = true },

      Winbar = { fg = '#F6F6F5' },
      WinbarSeparator = { fg = '#87E58E' },
      WinbarSpecial = { fg = fg_hl.fg },

      Treesitter = { fg = '#32CD32', bg = sl_bg }
    }

    for group, opts in pairs(groups) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
  group = vim.api.nvim_create_augroup('Statusline', { clear = true })
})
