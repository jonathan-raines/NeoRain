local M = {}
local fn = vim.fn

local modes = {
  ['n'] = 'NORMAL ',
  ['no'] = 'NORMAL ',
  ['v'] = 'VISUAL ',
  ['V'] = 'LINES  ',
  [''] = 'BLOCK  ',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT LINE',
  [''] = 'SELECT BLOCK',
  ['i'] = 'INSERT ',
  ['ic'] = 'INSERT ',
  ['R'] = 'REPLACE ',
  ['Rv'] = 'VISUAL REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

-- M.statusline_separators = {
--   default = {
--     left = '',
--     right = ' ',
--   },

--   round = {
--     left = '',
--     right = '',
--   },

--   block = {
--     left = '█',
--     right = '█',
--   },

--   arrow = {
--     left = '',
--     right = '',
--   },
-- }

M.Mode = function()
  local current_mode = vim.api.nvim_get_mode().mode
  return table.concat { '%#Normal#', ' ', modes[current_mode]:upper() }
end

M.FileInfo = function()
  local icon = '  '
  local filename = (fn.expand '%' == '' and 'Empty ') or fn.expand '%:t'

  if filename ~= 'Empty ' then
    local devicons_present, devicons = pcall(require, 'nvim-web-devicons')

    if devicons_present then
      local ft_icon = devicons.get_icon(filename)
      icon = (ft_icon ~= nil and ' ' .. ft_icon) or ''
    end
  end

  return table.concat { '%#Normal#', icon, ' ', filename, ' ' }
end

M.Git = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ''
  end

  local git_status = vim.b.gitsigns_status_dict

  local branch_name = '%#Normal#' .. '   ' .. git_status.head .. ' '
  local added = (git_status.added and git_status.added ~= 0) and ('%#DiffAdd#' .. '  ' .. git_status.added) or ''
  local changed = (git_status.changed and git_status.changed ~= 0) and ('%#DiffChange#' .. '  ' .. git_status.changed
    ) or ''
  local removed = (git_status.removed and git_status.removed ~= 0) and ('%#DiffDelete#' .. '  ' .. git_status.removed
    ) or ''

  return table.concat { branch_name, added, changed, removed }
end

M.LSP_Diagnostics = function()
  if not rawget(vim, 'lsp') then
    return ''
  end

  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

  errors = (errors and errors > 0) and ('%#DiagnosticError#' .. ' ' .. errors .. ' ') or ''
  warnings = (warnings and warnings > 0) and ('%#DiagnosticWarn#' .. '  ' .. warnings .. ' ') or ''
  hints = (hints and hints > 0) and ('%#DiagnosticHint#' .. 'ﯧ ' .. hints .. ' ') or ''
  info = (info and info > 0) and ('%#DiagnosticInfo#' .. ' ' .. info .. ' ') or ''

  return errors .. warnings .. hints .. info
end

M.LSP_status = function()
  if rawget(vim, 'lsp') then
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.attached_buffers[vim.api.nvim_get_current_buf()] then
        return (vim.o.columns > 100 and '%#Normal#' .. '   ' .. client.name .. ' ')
      end
    end
  end
  return ''
end

M.Treesitter = function()
  vim.cmd [[hi Treesitter guifg='seagreen']]

  if next(vim.treesitter.highlighter.active) then
    return '%#Treesitter#' .. ' '
  end
  return ''
end

return M
