local telescope = require 'telescope'

local function tmux_sessions()
  telescope.extensions.tmux.sessions {}
end

local function tmux_windows()
  telescope.extensions.tmux.windows {
    entry_format = '#S: #T',
  }
end

require('which-key').setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  key_labels = {
    ['<space>'] = 'SPC',
    ['<cr>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 8, -- spacing between columns
  },
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  ignore_missing = false,
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  ['<space>'] = 'which_key_ignore',
  ['b'] = 'which_key_ignore',
  ['c'] = 'which_key_ignore',
  ['C'] = 'which_key_ignore',
  ['e'] = { '<cmd>NvimTreeToggle<CR>', 'NvimTree' },
  ['q'] = 'which_key_ignore',
  ['w'] = 'which_key_ignore',
  l = {
    name = 'LSP',
    d = { '<cmd>Telescope lsp_document_diagnostics<cr>', 'Document Diagnostics' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format Buffer' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    j = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Go To Next' },
    k = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Go To Previous' },
    l = { "<cmd>lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})<CR>", 'Show Line Diagnostics' },
    r = { '<cmd>LspRestart<cr>', 'Restart LSP' },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Type Definition' },
    w = { '<cmd>Telescope lsp_workspace_diagnostics<cr>', 'Workspace Diagnostics' },
  },
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { '<cmd>Octo issue create<CR>', 'Create Issue' },
      l = { '<cmd>Octo issue list<CR>', 'List Issues' },
    },
    p = { '<cmd>Octo pr list<CR>', 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { '<cmd>Octo review start<CR>', 'Start Review' },
      f = { '<cmd>Octo review submit<CR>', 'Submit Review' },
    },
  },
  p = {
    name = 'Packer',
    c = { '<cmd>PackerCompile<CR>', 'PackerCompile' },
    s = { '<cmd>PackerSync<CR>', 'PackerSync' },
  },
  t = {
    name = 'Tmux',
    s = { tmux_sessions, 'Sessions' },
    w = { tmux_windows, 'Windows' },
  },
}

local wk = require 'which-key'
wk.register(mappings, opts)
