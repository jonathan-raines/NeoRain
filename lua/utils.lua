local M = {}

M.quick_fix_toggle = function()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')) == 1 then
    vim.cmd 'copen'
  else
    vim.cmd 'cclose'
  end
end

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

M.set_terminal_keymaps = function()
  local term_opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], term_opts)
end

M.get_client_names = function()
  local bufnr = vim.fn.bufnr ''
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.buf_get_clients(bufnr)
  local clientnames_tbl = {}

  for _, v in pairs(clients) do
    local filetypes = v.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and v.name then
      table.insert(clientnames_tbl, v.name)
    end
  end

  return table.concat(clientnames_tbl, ', ')
end

M.lsp_progress = function()
  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if Lsp then
    local msg = Lsp.message or ''
    local percentage = Lsp.percentage or 0
    local title = Lsp.title or ''

    local spinners = { '', '', '' }
    local success_icon = { '', '', '' }

    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    if percentage >= 70 then
      return string.format(' %%<%s %s %s (%s%%%%) ', success_icon[frame + 1], title, msg, percentage)
    end

    return string.format(' %%<%s %s %s (%s%%%%) ', spinners[frame + 1], title, msg, percentage)
  end

  return ''
end

return M
