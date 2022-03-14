require('toggleterm').setup {
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

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

local Terminal = require('toggleterm.terminal').Terminal

local horizontal = Terminal:new { hidden = true, direction = 'horizontal' }

function _HORIZONTAL_TOGGLE()
  horizontal:toggle()
end

local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local wk_ok, wk = pcall(require, 'which-key')
if not wk_ok then
  return
end

wk.register {
  g = {
    ['h'] = { '<cmd>lua _HORIZONTAL_TOGGLE()<CR>', 'Horizontal Terminal' },
    ['l'] = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
  },
}
