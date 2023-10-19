local M = {}

--- Sets global highlight group
---@param color string
---@param opts { fg: string, bold: boolean }
local function highlight(color, opts)
  vim.api.nvim_set_hl(0, color, opts)
end

--- Gets highlight group by name
---@param name string
---@return table
local function get_hl(name)
  return vim.api.nvim_get_hl_by_name(name, {})
end

--- Sets highlight groups for custom statusline
M.set_hl = function()
  highlight('St_NormalMode', { fg = '#32CD32', bold = true })
  highlight('St_InsertMode', { fg = '#FF7518', bold = true })
  highlight('St_VisualMode', { fg = '#DA70D6', bold = true })
  highlight('St_ReplaceMode', { fg = '#D2042D', bold = true })
  highlight('St_CommandMode', { fg = '#DFFF00', bold = true })
  highlight('St_TerminalMode', { fg = '#F4BB44', bold = true })
  highlight('St_NTerminalMode', { fg = '#93C572', bold = true })
  highlight('St_CurrentFile', { fg = '#00BFFF', bold = true })
  highlight('St_AlternateFile', { fg = '#20B2AA', bold = true })

  highlight('St_git_add', { fg = '#32CD32' })
  highlight('St_git_change', { fg = '#FF7518' })
  highlight('St_git_delete', { fg = '#D2042D' })

  highlight('Spacer', { bg = get_hl 'St_NormalMode'.background })
  highlight('LspClient', { bg = get_hl 'St_NormalMode'.background })
  highlight('Treesitter', { fg = '#32CD32', bg = get_hl 'St_NormalMode'.background })
end

--- Map VIM modes to custom highlight groups
M.modes = {
  ['n'] = { 'NORMAL', 'St_NormalMode' },
  ['niI'] = { 'NORMAL i', 'St_NormalMode' },
  ['niR'] = { 'NORMAL r', 'St_NormalMode' },
  ['niV'] = { 'NORMAL v', 'St_NormalMode' },
  ['no'] = { 'N-PENDING', 'St_NormalMode' },
  ['i'] = { 'INSERT', 'St_InsertMode' },
  ['ic'] = { 'INSERT (completion)', 'St_InsertMode' },
  ['ix'] = { 'INSERT completion', 'St_InsertMode' },
  ['t'] = { 'TERMINAL', 'St_TerminalMode' },
  ['nt'] = { 'NTERMINAL', 'St_NTerminalMode' },
  ['v'] = { 'VISUAL', 'St_VisualMode' },
  ['V'] = { 'V-LINE', 'St_VisualMode' },
  ['Vs'] = { 'V-LINE (Ctrl O)', 'St_VisualMode' },
  ['\22'] = { 'V-BLOCK', 'St_VisualMode' },
  ['\22s'] = { 'V-BLOCK', 'St_VisualMode' },
  ['R'] = { 'REPLACE', 'St_ReplaceMode' },
  ['Rv'] = { 'V-REPLACE', 'St_ReplaceMode' },
  ['s'] = { 'SELECT', 'St_SelectMode' },
  ['S'] = { 'S-LINE', 'St_SelectMode' },
  ['\19'] = { 'S-BLOCK', 'St_SelectMode' },
  ['c'] = { 'COMMAND', 'St_CommandMode' },
  ['cv'] = { 'COMMAND', 'St_CommandMode' },
  ['ce'] = { 'COMMAND', 'St_CommandMode' },
  ['r'] = { 'PROMPT', 'St_ConfirmMode' },
  ['rm'] = { 'MORE', 'St_ConfirmMode' },
  ['r?'] = { 'CONFIRM', 'St_ConfirmMode' },
  ['!'] = { 'SHELL', 'St_TerminalMode' },
}

--- Custom separators for statusline modules
M.statusline_separators = {
  default = {
    left = '',
    right = ' ',
  },
  round = {
    left = '',
    right = '',
  },
  block = {
    left = '█',
    right = '█',
  },
  arrow = {
    left = '',
    right = '',
  },
}

return M
