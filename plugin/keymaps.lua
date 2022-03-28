local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal Mode --
local normal_keymaps = {
  -- Alternate file
  ['<leader><space>'] = '<c-^>',

  -- Write / Quit
  ['<leader>w'] = '<cmd>up<CR>',
  ['<leader>q'] = 'ZZ',
  ['<leader>c'] = '<cmd>execute (v:count > 0 ? v:count : "") . "bd"<CR>',
  ['<leader>C'] = '<cmd>%bd|e#|bd#<CR>',

  -- Keeping it centered
  ['J'] = 'mzJ`z',
  ['n'] = 'nzzzv',
  ['N'] = 'Nzzzv',

  -- Quickfix Navigation
  [']q'] = '<cmd>execute (v:count > 1 ? v:count : 1) . "cnext"<CR>',
  ['[q'] = '<cmd>execute (v:count > 1 ? v:count : 1) . "cprevious"<CR>',

  -- Buffer Navigation
  ['<C-j>'] = '<cmd>bp<CR>',
  ['<C-k>'] = '<cmd>bn<CR>',

  -- Indent
  ['<'] = '<<',
  ['>'] = '>>',

  -- Add / Subtract
  ['+'] = '<C-a>',
  ['-'] = '<C-x>',

  -- Move Windows Around
  ['<C-h>'] = '<C-w>h',
  ['<C-l>'] = '<C-w>l',

  -- Move Lines Around
  ['<A-j>'] = ':m .+1<CR>==',
  ['<A-k>'] = ':m .-2<CR>==',

  -- Quickfix
  ['<C-q>'] = '<cmd>lua QuickFixToggle()<CR>',

  -- Resize windows
  ['<C-Up>'] = ':resize -5<CR>',
  ['<C-Down>'] = ':resize +5<CR>',
  ['<C-Left>'] = ':vertical resize -5<CR>',
  ['<C-Right>'] = ':vertical resize +5<CR>',
}

local insert_keymaps = {
  -- Escape
  ['jk'] = '<ESC>',

  -- Escape closing character
  ['<A-l>'] = '<cmd>lua EscapePair()<CR>',
}

local visual_keymaps = {
  ['jk'] = '<ESC>',

  -- Move Lines Around
  ['<A-j>'] = ":m '>+1<CR>gv-gv",
  ['<A-k>'] = ":m '<-2<CR>gv-gv",

  -- Indent
  ['<'] = '<gv',
  ['>'] = '>gv',
}

-- Center navigation commands
local navigation = { '{', '}', '<C-o>', '<C-i>', '<C-d>', '<C-u>', '<C-f>', '<C-b>', '*', '#' }
for _, char in ipairs(navigation) do
  keymap('n', char, char .. 'zz')
end

-- Undo break points
local break_points = { '<Space>', '-', '_', ':', '.', '/' }
for _, char in ipairs(break_points) do
  keymap('i', char, char .. '<C-g>u')
end

-- Map Normal Mode
for key, cmd in pairs(normal_keymaps) do
  keymap('n', key, cmd, opts)
end

-- Map Insert Mode
for key, cmd in pairs(insert_keymaps) do
  keymap('i', key, cmd, opts)
end

-- Map Visual Mode
for key, cmd in pairs(visual_keymaps) do
  keymap('v', key, cmd, opts)
end

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

-- QuickFixToggle
function QuickFixToggle()
  if vim.fn.empty(vim.fn.filter(vim.fn.getwininfo(), 'v:val.quickfix')) == 1 then
    vim.cmd 'copen'
  else
    vim.cmd 'cclose'
  end
end

function EscapePair()
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

-- vim.api.nvim_exec(
--   [[
--     :function StayCenteredI()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    let col = getcurpos()[4]
--     :    normal! zz
--     :    call cursor(line, col)
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     :function StayCentered()
--     :  let line = line(".")
--     :  if line != get(b:, 'last_line', 0)
--     :    normal! zz
--     :    let b:last_line = line
--     :  endif
--     :endfunction
--     augroup StayCentered
--       autocmd!
--       autocmd CursorMovedI * :call StayCenteredI()
--       autocmd CursorMoved * :call StayCentered()
--     augroup END
--   ]],
--   true
-- )
