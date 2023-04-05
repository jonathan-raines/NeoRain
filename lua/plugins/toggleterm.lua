return {
  'akinsho/toggleterm.nvim',
  config = function()
    require 'toggleterm'.setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 1,     -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = true,
      direction = 'float',
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell,  -- change the default shell
      float_opts = {
        border = 'rounded',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    }

    local Terminal = require 'toggleterm.terminal'.Terminal

    function _Lazygit_toggle()
      Terminal:new { cmd = 'lazygit', count = 76, hidden = true }:toggle()
    end
  end,
  keys = {
    { [[<c-\>]] },
    -- { '<leader>gl', '<cmd>lua _Lazygit_toggle()<CR>', desc = 'Lazygit' },
  }
}
