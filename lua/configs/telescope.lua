local M = {}

function _CURR_BUF()
  local opt = require 'telescope.themes'.get_ivy()
  require 'telescope.builtin'.current_buffer_fuzzy_find(opt)
end

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>fb'] = '<cmd>Telescope buffers theme=get_ivy<CR>',
    ['<leader>fc'] = '<cmd>Telescope command_history<CR>',
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

  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
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

    wk.register(mappings, { prefix = '<leader>' })
  end
end

M.config = function()
  local actions = require 'telescope.actions'

  require 'telescope'.setup {
    defaults = {
      layout_config = {
        height = 0.85,
        width = 0.95,
      },
      file_sorter = require 'telescope.sorters'.get_fzy_sorter,
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
        },
        n = {},
      },
      -- Remove indentation at the beginning of a line
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim', -- add this value
      },
    },
    pickers = {
      buffers = {
        show_all_buffers = true,
        ignore_current_buffer = true,
        sort_lastused = true,
        mappings = {
          i = {
            ['<A-d>'] = actions.delete_buffer,
          },
          n = {
            ['<A-d>'] = actions.delete_buffer,
          },
        },
      },
      current_buffer_fuzzy_find = {
        previewer = false,
      },
      find_files = {
        hidden = true,
        file_ignore_patterns = { '.git/' },
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      },
      live_grep = {
        file_ignore_patterns = { '.git/' },
      },
      selection_strategy = 'reset',
      use_less = true,
    },
  }
end

return M
