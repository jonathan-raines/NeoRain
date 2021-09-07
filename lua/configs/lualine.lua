local window_width_limit = 80

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > window_width_limit
  end,
}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function getclientnames()
  local bufnr = vim.fn.bufnr ''
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.buf_get_clients(bufnr)
  local clientnames_tbl = {}

  for _, v in pairs(clients) do
    local filetypes = v.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and v.name then
      table.insert(clientnames_tbl, v.name)
    end
  end

  return table.concat(clientnames_tbl, ', ')
end

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
    theme = 'catppuccino',
  },
  sections = {
    lualine_a = {
      {
        function()
          return ' '
        end,
        left_padding = 0,
        right_padding = 0,
        condition = nil,
      },
    },
    lualine_b = {
      {
        'branch',
        color = { bg = '#0B1115' },
        condition = nil,
      },
    },
    lualine_c = {
      {
        'filename',
        color = { fg = '#898E99' },
        -- condition = conditions.buffer_not_empty,
      },
      {
        'diff',
        source = diff_source,
        symbols = { added = '  ', modified = '柳', removed = ' ' },
        color_added = { fg = '#97c374' },
        color_modified = { fg = '#dbc074' },
        color_removed = { fg = '#c94f6d' },
        color = {},
        condition = nil,
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        condition = nil,
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
      {
        function()
          local bufnr = vim.fn.bufnr ''
          local clients = vim.lsp.buf_get_clients(bufnr)
          if vim.tbl_isempty(clients) then
            return ''
          end
          local names = getclientnames()
          return string.format('%s', names)
        end,
        icon = ' ',
      },
      {
        'filetype',
        color = { fg = '#898E99' },
        condition = conditions.hide_in_width,
      },
    },
    lualine_y = {},
    lualine_z = {
      {
        function()
          local current_line = vim.fn.line '.'
          local total_lines = vim.fn.line '$'
          local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
          local line_ratio = current_line / total_lines
          local index = math.ceil(line_ratio * #chars)
          return chars[index]
        end,
        left_padding = 0,
        right_padding = 0,
        color = { fg = '#61afef', bg = '#0B1115' },
      },
    },
  },
}
