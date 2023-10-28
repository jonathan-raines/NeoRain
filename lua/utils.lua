local M = {}

local silent_mods = { mods = { silent = true, emsg_silent = true } }

-- Toggle the quickfix/loclist window.
-- When toggling these, ignore error messages and restore the cursor to the original window when opening the list.
M.quickfix_toggle = function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose(silent_mods)
  elseif #vim.fn.getqflist() > 0 then
    local win = vim.api.nvim_get_current_win()
    vim.cmd.copen(silent_mods)
    if win ~= vim.api.nvim_get_current_win() then
      vim.cmd.wincmd 'p'
    end
  end
end

M.locallist_toggle = function()
  if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
    vim.cmd.lclose(silent_mods)
  elseif #vim.fn.getloclist(0) > 0 then
    local win = vim.api.nvim_get_current_win()
    vim.cmd.lopen(silent_mods)
    if win ~= vim.api.nvim_get_current_win() then
      vim.cmd.wincmd 'p'
    end
  end
end

M.floating_terminal = function()
  local cwd = vim.fn.expand '%:p:h'
  ---@cast cwd string
  if vim.startswith(cwd, 'term') then
    vim.cmd 'close'
  else
    require('float_term').float_term(nil, { cwd = cwd })
  end
end

return M
