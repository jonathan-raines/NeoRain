local M = {}
local highlight = require 'utils'.highlight

M.set_hl = function()
  highlight('St_NormalMode', { fg = 'Green', bold = true })
  highlight('St_InsertMode', { fg = 'Cyan', bold = true })
  highlight('St_VisualMode', { fg = 'Magenta', bold = true })
  highlight('St_ReplaceMode', { fg = 'Red', bold = true })
  highlight('St_CommandMode', { fg = 'Yellow', bold = true })
  highlight('St_TerminalMode', { fg = 'LightGreen', bold = true })
  highlight('St_NTerminalMode', { fg = 'LightGreen', bold = true })
  highlight('St_CurrentFile', { fg = 'DarkYellow', bold = true })
  highlight('St_AlternateFile', { fg = 'DarkCyan', bold = true })
end

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
  [''] = { 'V-BLOCK', 'St_VisualMode' },
  ['R'] = { 'REPLACE', 'St_ReplaceMode' },
  ['Rv'] = { 'V-REPLACE', 'St_ReplaceMode' },
  ['s'] = { 'SELECT', 'St_SelectMode' },
  ['S'] = { 'S-LINE', 'St_SelectMode' },
  [''] = { 'S-BLOCK', 'St_SelectMode' },
  ['c'] = { 'COMMAND', 'St_CommandMode' },
  ['cv'] = { 'COMMAND', 'St_CommandMode' },
  ['ce'] = { 'COMMAND', 'St_CommandMode' },
  ['r'] = { 'PROMPT', 'St_ConfirmMode' },
  ['rm'] = { 'MORE', 'St_ConfirmMode' },
  ['r?'] = { 'CONFIRM', 'St_ConfirmMode' },
  ['!'] = { 'SHELL', 'St_TerminalMode' },
}

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
