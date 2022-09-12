local lsp = require 'feline.providers.lsp'
local vi_mode = require 'feline.providers.vi_mode'
local utils = require 'utils'

local components = {
  active = { {}, {}, {} },
  inactive = { {}, {}, {} },
}

components.active[1] = {
  {
    name = 'mode color',
    provider = '▊',
    hl = function()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = vi_mode.get_mode_color(),
      }
    end
  },
  {
    name = 'mode',
    provider = function()
      return vi_mode.get_vim_mode()
    end,
    hl = function()
      return {
        name = vi_mode.get_mode_highlight_name(),
        fg = vi_mode.get_mode_color(),
        style = 'bold',
      }
    end,
    left_sep = '  ',
    right_sep = '  '
  },
  {
    provider = 'git_branch',
    hl = {
      fg = 'white',
      style = 'bold',
    },
    right_sep = '  '
  },
  {
    provider = 'file_info',
    right_sep = '  '
  },
  {
    provider = 'git_diff_added',
    hl = { fg = 'green' }
  },
  {
    provider = 'git_diff_changed',
    hl = { fg = 'orange' }
  },
  {
    provider = 'git_diff_removed',
    hl = { fg = 'red' }
  },
}

components.active[3] = {
  {
    name = 'lsp',
    provider = function()
      return utils.get_client_names()
    end,
    icon = '  ',
    right_sep = '  '
  },
  {
    name = 'treesitter',
    provider = function()
      if next(vim.treesitter.highlighter.active) then
        return '  '
      end
      return ''
    end,
    hl = { fg = '#008080' },
    right_sep = '  '
  },
}

require 'feline'.setup {
  components = components
}
