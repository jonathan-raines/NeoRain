local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'
local utils = require 'utils'

local vi_mode_text = {
  n = 'NORMAL',
  i = 'INSERT',
  v = 'VISUAL',
  [''] = 'V-BLOCK',
  V = 'V-LINE',
  c = 'COMMAND',
  no = 'UNKNOWN',
  s = 'UNKNOWN',
  S = 'UNKNOWN',
  ic = 'UNKNOWN',
  R = 'REPLACE',
  Rv = 'UNKNOWN',
  cv = 'UNKWON',
  ce = 'UNKNOWN',
  r = 'REPLACE',
  rm = 'UNKNOWN',
  t = 'INSERT'
}

local components = {
  active = { {}, {}, {} },
  inactive = { {}, {}, {} },
}

components.active[1] = {
  {
    provider = '▊',
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
        style = 'bold',
      }
    end,
    right_sep = ' '
  },
  {
    provider = function()
      return vi_mode_text[vim.fn.mode()]
    end,
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
        style = 'bold',
      }
    end,
    left_sep = ' ',
    right_sep = '  '
  },
  {
    provider = 'git_branch',
    hl = {
      fg = 'white',
      style = 'bold',
    },
    right_sep = {
      str = '  ',
      hl = {
        fg = 'NONE',
      },
    },
  },
  {
    provider = 'file_info',
    right_sep = {
      str = '  ',
      hl = {
        fg = 'NONE',
      },
    },
  },
  {
    provider = 'git_diff_added',
    hl = {
      fg = 'green',
    },
    right_sep = {
      str = ' ',
      hl = {
        fg = 'NONE',
      },
    },
  },
  {
    provider = 'git_diff_changed',
    hl = {
      fg = 'orange',
    },
    right_sep = {
      str = ' ',
      hl = {
        fg = 'NONE',
      },
    },
  },
  {
    provider = 'git_diff_removed',
    hl = {
      fg = 'red',
    },
    right_sep = {
      str = ' ',
      hl = {
        fg = 'NONE',
      },
    },
  },
}

components.active[3] = {
  {
    provider = function()
      return utils.get_client_names()
    end,
    icon = '  ',
    right_sep = {
      str = '  ',
      hl = {
        fg = 'NONE',
      },
    },
  },
  {
    provider = function()
      if next(vim.treesitter.highlighter.active) then
        return '  '
      end
      return ''
    end,
    hl = {
      fg = '#008080',
    },
    right_sep = {
      str = ' ',
      hl = {
        fg = 'NONE',
      },
    },
  },
}

require 'feline'.setup {
  components = components
}
