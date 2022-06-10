local augroups = {}

augroups.misc = {
  create_missing_directories = {
    desc = 'Create missing directories before saving the buffer',
    event = 'BufWritePre',
    callback = function()
      vim.fn.mkdir(vim.fn.expand '%:p:h', 'p')
    end,
  },
  cursor_location = {
    desc = 'Open file at the last position it was edited earlier',
    event = 'BufReadPost',
    pattern = '*',
    command = 'silent! normal! g`"zv',
  },
  hide_cursorline = {
    desc = 'Hide cursorline in inactive window',
    event = 'WinLeave',
    pattern = '*',
    callback = function()
      vim.opt_local.cursorline = false
    end,
  },
  highlight_yank = {
    desc = 'Highland text on yank',
    event = 'TextYankPost',
    pattern = '*',
    callback = function()
      vim.highlight.on_yank { higroup = 'Visual' }
    end
  },
  newline_comment = {
    desc = 'No commenting new line',
    event = 'BufEnter',
    pattern = '*',
    command = 'set fo-=c fo-=r fo-=o',
  },
  quit_filetypes = {
    desc = 'Use q to quit certain filetypes',
    event = 'FileType',
    pattern = 'help,man,lspinfo,qf',
    callback = function()
      vim.keymap.set('n', 'q', '<cmd>quit<CR>', { buffer = true })
    end,
  },
  show_cursorline = {
    desc = 'Hide cursorline in inactive window',
    event = 'WinEnter',
    pattern = '*',
    callback = function()
      vim.opt_local.cursorline = true
    end,
  },
  statusline_border = {
    desc = 'Thin border between windows on global statusline',
    event = 'VimEnter',
    command = 'highlight WinSeparator guibg=None',
  },
  trim_whitespace = {
    desc = 'Trim whitespace on save',
    event = 'BufWritePre',
    pattern = '*',
    command = [[:%s/\s\+$//e]],
  }
}

augroups.terminal = {
  close_terminal = {
    desc = 'Close terminal with bd',
    event = 'TermClose',
    pattern = '*',
    command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
  },
  kill_process = {
    desc = '',
    event = 'TermOpen',
    pattern = '*',
    command = 'nnoremap <buffer> <C-c> i<C-c>',
  },
  set_keymaps = {
    event = 'TermOpen',
    group = 'NeovimTerminal',
    pattern = 'term://*',
    command = "lua require('utils').set_terminal_keymaps()",
  },
  set_terminal_options = {
    desc = 'Set terminal options',
    event = 'TermOpen',
    pattern = '*',
    command = 'set nonumber norelativenumber nobuflisted',
  },
  start_insert_mode = {
    desc = 'Start terminal in insert mode',
    event = 'TermOpen',
    pattern = '*',
    command = 'startinsert',
  }
}

for group, commands in pairs(augroups) do
  local augroup = vim.api.nvim_create_augroup('AU_' .. group, { clear = true })

  for _, opts in pairs(commands) do
    local event = opts.event
    opts.event = nil
    opts.group = augroup
    vim.api.nvim_create_autocmd(event, opts)
  end
end
