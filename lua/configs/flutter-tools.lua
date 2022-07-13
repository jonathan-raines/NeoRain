require 'flutter-tools'.setup {
  lsp = {
    on_attach = require 'lsp.handlers'.on_attach(),
  },
}

vim.keymap.set('n', '<leader>fy', '<CMD>Telescope flutter commands theme=dropdown<CR>',
  { noremap = true, silent = true, desc = 'Flutter Commands' })
