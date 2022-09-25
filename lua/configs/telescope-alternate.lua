local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>',
    { silent = true, remap = true, desc = 'Alternate Files' })
end

M.config = function()
  require 'telescope-alternate'.setup {
    mappings = {
      { 'app/models/(.*).rb', {
        { 'spec/requests/**/*[1:pluralize]_spec.rb', 'Request Test' },
        { 'spec/models/**/*[1:singularize]_spec.rb', 'Model Test' }
      }
      },
      { 'app/controllers(.*)/(.*)_controller.rb', {
        { 'spec/requests[1]/[2]*_spec.rb', 'Request Test' },
      }
      },
    },
    presets = { 'rails' }, -- Telescope pre-defined mapping presets
  }

  -- On your telescope:
  require 'telescope'.load_extension 'telescope-alternate'
end

return M
