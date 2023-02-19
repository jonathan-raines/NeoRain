local M = {}

--- Close all hidden and unmodified buffers
M.close_other_buffers = function()
  local api = vim.api
  local active_buffers = {}
  for _, win in ipairs(api.nvim_list_wins()) do
    active_buffers[api.nvim_win_get_buf(win)] = true
  end
  local count = 0
  local buffers = api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if
        active_buffers[buf] ~= true
        and api.nvim_buf_get_option(buf, 'modified') ~= true
        and api.nvim_buf_get_option(buf, 'buftype') ~= 'terminal'
    then
      api.nvim_buf_delete(buf, {})
      count = count + 1
    end
  end
  api.nvim_out_write(string.format('Deleted %d hidden and unmodified buffers\n', count))
end

--- In insert mode jump to closing character or next comma
M.escape_pair = function()
  local closers = { ')', ']', '}', '>', "'", '"', '`', ',' }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

--- Sets terminal keymaps for escaping insert mode and window
M.set_terminal_keymaps = function()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

--- Sets global highlight group
---@param color string
---@param opts { fg: string, bold: boolean }
M.highlight = function(color, opts)
  vim.api.nvim_set_hl(0, color, opts)
end

return M
