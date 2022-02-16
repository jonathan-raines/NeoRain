local keymap = vim.api.nvim_set_keymap
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
keymap('n', '<leader><space>', '<c-^>', opts)

-- Write / Quit
keymap('n', '<leader>w', '<cmd>up<CR>', opts)
keymap('n', '<leader>q', 'ZZ', opts)
keymap('n', '<leader>c', '<cmd>bd<CR>', opts)
keymap('n', '<leader>C', '<cmd>call DeleteHiddenBuffers()<CR>', opts)

-- Keeping it centered
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)
keymap('n', 'J', 'mzJ`z', opts)
keymap('n', '{', '{zz', opts)
keymap('n', '}', '}zz', opts)
keymap('n', '<C-o>', '<C-o>zz', opts)
keymap('n', '<C-i>', '<C-i>zz', opts)

-- Quickfix Navigation
keymap('n', ']q', '<cmd>cnext<CR>', opts)
keymap('n', '[q', '<cmd>cprevious<CR>', opts)
keymap('n', ']Q', '<cmd>cfirst<CR>', opts)
keymap('n', '[Q', '<cmd>clast<CR>', opts)

-- Buffer Navigation
keymap('n', ']b', '<cmd>bn<CR>', opts)
keymap('n', '[b', '<cmd>bp<CR>', opts)
keymap('n', ']B', '<cmd>blast<CR>', opts)
keymap('n', '[B', '<cmd>bfirst<CR>', opts)

-- Move Lines Around
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)

-- Indent
keymap('n', '<', '<<', opts)
keymap('n', '>', '>>', opts)

-- Add / Subtract
keymap('n', '+', '<C-a>', opts)
keymap('n', '-', '<C-x>', opts)

-- Quickfix
keymap('n', '<C-q>', '<cmd>call QuickFixToggle()<CR>', opts)

-- Move Windows Around
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize windows
keymap('n', '<C-Up>', ':resize -5<CR>', opts)
keymap('n', '<C-Down>', ':resize +5<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -5<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +5<CR>', opts)

-- Insert Mode --

-- Undo break points
keymap('i', ',', ',<c-g>u', opts)
keymap('i', '.', '.<c-g>u', opts)
keymap('i', '!', '!<c-g>u', opts)
keymap('i', '?', '?<c-g>u', opts)

-- Escape
keymap('i', 'jk', '<ESC>', opts)

-- Visual Mode --
keymap('v', 'jk', '<ESC>', opts)

-- Move Lines Around
keymap('v', '<A-j>', ":m '>+1<CR>gv-gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv-gv", opts)

-- Indent
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Jumplist mutations
vim.cmd 'nnoremap <expr> j (v:count > 5 ? "m\'" . v:count : "") . "j"'
vim.cmd 'nnoremap <expr> k (v:count > 5 ? "m\'" . v:count : "") . "k"'

-- QuickFixToggle
vim.api.nvim_exec(
  [[
  function! QuickFixToggle()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
      copen
      else
      cclose
      endif
  endfunction]],
  false
)

-- Delete Hidden Buffers
vim.api.nvim_exec(
  [[
  function! DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout!' buf
		endfor
	endfunction]],
  false
)

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

vim.api.nvim_set_keymap('i', '<A-l>', '<cmd>lua EscapePair()<CR>', { noremap = true, silent = true })
