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
      {
        'branch',
        cond = nil,
      },
    },
    lualine_c = {
      {
        'filename',
      },
      {
        'diff',
        source = diff_source,
        symbols = { added = '  ', modified = '柳', removed = ' ' },
        diff_color = {
          added = { fg = '#97c374' },
          modified = { fg = '#dbc074' },
          removed = { fg = '#c94f6d' },
        },
        color = {},
      },
      {
        function()
          local gps = require 'nvim-gps'
          return gps.get_location()
        end,
        cond = function()
          local gps = require 'nvim-gps'
          return pcall(require, 'nvim-treesitter.parsers') and gps.is_available()
        end,
        color = { fg = '#7fb4ca' },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        cond = nil,
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
        cond = conditions.hide_in_width,
      },
    },
    lualine_y = {
      -- { require('github-notifications').statusline_notification_count },
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
