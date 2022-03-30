local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local keymaps = {
  ['<leader>b'] = '<cmd>Telescope buffers theme=get_ivy<CR>',
  ['<leader>fb'] = '<cmd>Telescope buffers theme=get_ivy<CR>',
  ['<leader>fc'] = '<cmd>Telescope colorscheme<CR>',
  ['<leader>fd'] = '<cmd>Telescope lsp_document_symbols<CR>',
  ['<leader>fe'] = '<cmd>Telescope file_browser<CR>',
  ['<leader>ff'] = '<cmd>Telescope find_files<CR>',
  ['<leader>fh'] = '<cmd>Telescope git_status<CR>',
  ['<leader>fg'] = '<cmd>Telescope live_grep<CR>',
  ['<leader>fo'] = '<cmd>Telescope oldfiles cwd_only=v:true<CR>',
  ['<leader>fq'] = '<cmd>Telescope quickfix<CR>',
  ['<leader>fr'] = '<cmd>Telescope resume<CR>',
  ['<leader>fs'] = '<cmd>Telescope grep_string<CR>',
  ['<leader>ft'] = '<cmd>Telescope treesitter<CR>',
  ['<leader>fw'] = '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
  ['<leader>/'] = '<cmd>lua _CURR_BUF()<CR>',
}

for key, cmd in pairs(keymaps) do
  keymap('n', key, cmd, opts)
end

local mappings = {
  b = { 'Buffers' },
  f = {
    name = 'Telescope',
    b = { 'Buffers' },
    c = { 'Colorscheme' },
    d = { 'Document Symbols' },
    f = { 'Find Files' },
    e = { 'File Browser' },
    g = { 'Live Grep' },
    h = { 'Git Status' },
    o = { 'Open Recent File' },
    q = { 'Open Quickfix' },
    r = { 'Resume Last Picker' },
    s = { 'Grep String' },
    t = { 'Treesitter' },
    w = { 'Workplace Symbols' },
  },
  ['/'] = { 'Search Current Buffer' },
}

require('which-key').register(mappings, { prefix = '<leader>' })
