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
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        -- fmt = function()
        --   return ' '
        -- end,
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
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        filetype_names = {
          TelescopePrompt = 'Telescope',
          dashboard = 'Dashboard',
          packer = 'Packer',
          fzf = 'FZF',
          qf = 'QuickFix',
        }, -- shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
        mode = 2,
        max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
        -- it can also be a function that returns
        -- the value of `max_length` dynamically.
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'tabs' },
  },
  extensions = { 'quickfix', 'toggleterm' },
}
