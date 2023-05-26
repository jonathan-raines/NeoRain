return {
  'nvim-lualine/lualine.nvim',
  config = function()
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
        lualine_b = { 'branch', },
        lualine_c = {
          'filename',
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
            symbols = { added = '  ', modified = '  ', removed = '  ' },
          },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = '  ', info = ' ', hint = ' ' },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
          }
        },
        lualine_y = {
          {
            function()
              if next(vim.treesitter.highlighter.active) then
                return ' '
              end
              return ''
            end,
            color = { fg = '#519F50' },
          },
        },
        lualine_z = {
          {
            function()
              if rawget(vim, 'lsp') then
                local client_names = {}
                for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
                  table.insert(client_names, client.name)
                end
                return table.concat(client_names, ',')
              end
              return ''
            end,
            icon = ' ',
          },
        },
      },
      tabline = {},
      winbar = {},
      extensions = { 'quickfix', 'toggleterm', 'fugitive', 'lazy' },
    }
  end,
  event = 'VeryLazy'
}
