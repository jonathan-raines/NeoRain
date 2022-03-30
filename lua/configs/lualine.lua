local utils = require 'utils'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
    },
    lualine_b = {
      'branch',
      require('github-notifications').statusline_notification_count,
    },
    lualine_c = {
      {
        'filename',
      },
      {
        'diff',
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
        symbols = { added = '  ', modified = '柳', removed = ' ' },
        diff_color = {
          added = { fg = '#97c374' },
          modified = { fg = '#dbc074' },
          removed = { fg = '#c94f6d' },
        },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      },
      {
        function()
          if next(vim.treesitter.highlighter.active) then
            return '  '
          end
          return ''
        end,
        color = { fg = '#008080' },
      },
      { -- List attached lsp servers
        function()
          return utils.get_client_names()
        end,
        icon = ' ',
      },
      { utils.lsp_progress() },
      { 'filetype' },
    },
    lualine_z = {
      {
        'location',
        separator = { left = '', right = '' },
        padding = { left = 1, right = 1 },
      },
    },
  },
  extensions = { 'quickfix', 'toggleterm' },
}
