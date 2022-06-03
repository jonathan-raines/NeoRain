local M = {}

function M.setup()
  local wk_ok, wk = pcall(require, 'which-key')
  if wk_ok then
    local mappings = {
      j = {
        name = 'Terminal',
        d = { '<cmd>lua _LAZYDOCKER_TOGGLE()<CR>', 'Lazy Docker' },
        l = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazy Git' },
      },
    }

    wk.register(mappings, { prefix = '<leader>' })
  end
end

function M.config()
  require 'toggleterm'.setup {
    -- size can be a number or function which is passed the current terminal
    size = 20 or function(term)
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
    shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
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
  local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }
  local lazydocker = Terminal:new { cmd = 'lazydocker', hidden = true }

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  function _LAZYDOCKER_TOGGLE()
    lazydocker:toggle()
  end
end

return M
