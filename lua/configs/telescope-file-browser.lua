local telescope = require 'telescope'

telescope.setup {
  extensions = {
    file_browser = {
      theme = 'ivy',
      mappings = {
        ['i'] = {},
        ['n'] = {},
      },
    },
  },
}

telescope.load_extension 'file_browser'
