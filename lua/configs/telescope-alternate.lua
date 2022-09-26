local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>fa', '<cmd>Telescope telescope-alternate alternate_file initial_mode=normal<CR>',
    { silent = true, remap = true, desc = 'Alternate Files' })
end

M.config = function()
  require 'telescope-alternate'.setup {
    mappings = {
      { 'app/models/(.*).rb', {
        { 'spec/factories/**/*[1:pluralize].rb', 'Factory' }
      } },
      { 'app/controllers(.*)/(.*)_controller.rb', {
        { 'spec/factories/**/*[2].rb', 'Factory' }
      } },
    },
    presets = { 'rails', 'rspec' }, -- Telescope pre-defined mapping presets
  }

  -- On your telescope:
  require 'telescope'.load_extension 'telescope-alternate'
end

return M
