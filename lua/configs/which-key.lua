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
    ['<CR>'] = 'RET',
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
  ['c'] = 'which_key_ignore',
  ['C'] = 'which_key_ignore',
  ['e'] = { ':NvimTreeToggle<CR>', 'NvimTree' },
  ['q'] = 'which_key_ignore',
  ['w'] = 'which_key_ignore',
  ['b'] = 'Buffers',
  l = {
    name = 'LSP',
    d = { ':Telescope lsp_document_diagnostics<CR>', 'Document Diagnostics' },
    f = { ':lua vim.lsp.buf.formatting()<CR>', 'Format Buffer' },
    i = { ':LspInfo<CR>', 'Info' },
    j = { ':lua vim.diagnostic.goto_next()<CR>', 'Go To Next' },
    k = { ':lua vim.diagnostic.goto_prev()<CR>', 'Go To Previous' },
    l = { ":lua vim.diagnostic.open_float(0, {scope = 'line', border = 'single'})<CR>", 'Show Line Diagnostics' },
    r = { ':LspRestart<CR>', 'Restart LSP' },
    t = { ':lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
    w = { ':Telescope lsp_workspace_diagnostics<CR>', 'Workspace Diagnostics' },
  },
  o = {
    name = 'Octo',
    i = {
      name = 'Issues',
      c = { ':Octo issue create<CR>', 'Create Issue' },
      l = { ':Octo issue list<CR>', 'List Issues' },
    },
    p = { ':Octo pr list<CR>', 'List Pull Requests' },
    r = {
      name = 'Review',
      s = { ':Octo review start<CR>', 'Start Review' },
      f = { ':Octo review submit<CR>', 'Submit Review' },
    },
  },
  p = {
    name = 'Packer',
    c = { ':PackerCompile<CR>', 'PackerCompile' },
    s = { ':PackerSync<CR>', 'PackerSync' },
    t = { ':StartupTime<CR>', 'Startup Time' },
  },
  t = {
    name = 'Testing',
    f = { ':TestFile<CR>', 'Run Test File' },
    l = { ':TestLast<CR>', 'Run Last Test' },
    n = { ':TestNearest<CR>', 'Run Nearest Test' },
    s = { ':TestSuite<CR>', 'Run Test Suite' },
    v = { ':TestVisit<CR>', 'Visit Test File' },
  },
}

local wk = require 'which-key'
wk.register(mappings, opts)
