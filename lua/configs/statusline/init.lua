vim.api.nvim_create_autocmd({ "VimEnter", "Colorscheme" }, {
  desc = 'Set highlights for Statusline',
  group = vim.api.nvim_create_augroup('Statusline', { clear = true }),
  pattern = '*',
  callback = function()
    _G_statusline_hls = {}

    local fg_hl = vim.api.nvim_get_hl(0, { name = '@keyword', link = false })
    local sl_bg = '#1E1F29'

    local groups = {
      StatusLine = { fg = '#F6F6F5', bg = sl_bg },

      StatuslineModeNormal = { fg = sl_bg, bg = '#32CD32', bold = true },
      StatuslineModeSeparatorNormal = { fg = '#32CD32', bg = 'None', bold = true },

      StatuslineModeInsert = { fg = sl_bg, bg = '#FF7518', bold = true },
      StatuslineModeSeparatorInsert = { fg = '#FF7518', bg = 'None', bold = true },

      StatuslineModeVisual = { fg = sl_bg, bg = '#DA70D6', bold = true },
      StatuslineModeSeparatorVisual = { fg = '#DA70D6', bg = 'None', bold = true },

      StatuslineModeReplace = { fg = sl_bg, bg = '#D2042D', bold = true },
      StatuslineModeSeparatorReplace = { fg = '#D2042D', bg = 'None', bold = true },

      StatuslineModeCommand = { fg = sl_bg, bg = '#DFFF00', bold = true },
      StatuslineModeSeparatorCommand = { fg = '#DFFF00', bg = 'None', bold = true },

      StatuslineModeTerminal = { fg = sl_bg, bg = '#F4BB44', bold = true },
      StatuslineModeSeparatorTerminal = { fg = '#F4BB44', bg = 'None', bold = true },

      StatuslineModeNTerminal = { fg = sl_bg, bg = '#93C572', bold = true },
      StatuslineModeSeparatorNTerminal = { fg = '#93C572', bg = 'None', bold = true },

      StatuslineModeSeparatorOther = { fg = '#FFBFA9', bg = 'None', bold = true },
      StatuslineItalic = { fg = '#A9ABAC', bg = 'None', italic = true },
      StatuslineSpinner = { fg = '#97EDA2', bg = 'None', bold = true },
      StatuslineTitle = { fg = '#FFFFFF', bg = 'None', bold = true },

      Winbar = { fg = '#F6F6F5' },
      WinbarSeparator = { fg = '#87E58E' },
      WinbarSpecial = { fg = fg_hl.fg },

      Treesitter = { fg = '#32CD32', bg = 'None' }
    }

    for group, opts in pairs(groups) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end
})

vim.o.statusline = "%!v:lua.require'configs.statusline.modules'.render()"
