-- Highlight on yank
vim.api.nvim_exec(
  [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
    augroup end
  ]],
  false
)

vim.api.nvim_exec(
  [[
    augroup TrimWhitespace
      autocmd!
      autocmd BufWritePre * %s/\s\+$//e
    augroup end
  ]],
  false
)

vim.cmd [[
  augroup CursorLocation
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
  augroup end
]] --Return to last cursor location in a file

vim.api.nvim_exec(
  [[
    augroup NeovimTerminal
      autocmd!
      autocmd TermOpen * startinsert
      autocmd TermOpen * :set nonumber norelativenumber
      autocmd TermOpen * :set nobuflisted
      autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
      autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
    augroup end
  ]],
  false
)

-- Prevents auto comment new line
vim.cmd 'au BufEnter * set fo-=c fo-=r fo-=o'
