require('which-key').setup {
  plugins = {
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
    },
  },
  key_labels = {
    ['<space>'] = 'SPC',
    ['<CR>'] = 'RET',
    ['<tab>'] = 'TAB',
  },
  window = {
    border = 'single', -- none, single, double, shadow
  },
  layout = {
    spacing = 8, -- spacing between columns
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
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
  ['e'] = 'which_key_ignore',
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
