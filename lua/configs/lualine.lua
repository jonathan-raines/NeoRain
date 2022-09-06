local utils = require 'utils'

require 'lualine'.setup {
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
        separator = { right = '' },
      },
    },
    lualine_b = { 'branch' },
    lualine_c = {
      { 'filename' },
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
        symbols = { added = ' ', modified = '柳', removed = ' ' },
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
            return ' '
          end
          return ''
        end,
        color = { fg = '#519F50' },
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
      { 'tabs' },
    },
  },
  tabline = {},
  extensions = { 'quickfix', 'toggleterm' },
}
