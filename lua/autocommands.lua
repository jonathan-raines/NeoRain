local augroups = {}

augroups.misc = {
  cursor_location = {
    desc = 'Open file at the last position it was edited earlier',
    event = 'BufReadPost',
    pattern = '*',
    command = 'silent! normal! g`"zv',
  },
  highlight_yank = {
    desc = 'Highland text on yank',
    event = 'TextYankPost',
    pattern = '*',
    callback = function()
      vim.highlight.on_yank { higroup = 'Visual' }
    end
  },
  trim_whitespace = {
    desc = 'Trim whitespace on save',
    event = 'BufWritePre',
    pattern = '*',
    command = [[:%s/\s\+$//e]],
  }
}

augroups.terminal = {
  set_keymaps = {
    event = 'TermOpen',
    group = 'NeovimTerminal',
    pattern = 'term://*',
    command = "lua require('utils').set_terminal_keymaps()",
  },
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
