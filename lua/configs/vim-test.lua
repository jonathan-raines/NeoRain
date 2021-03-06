local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>tf'] = { '<cmd>TestFile<CR>', { desc = 'Test File' } },
    ['<leader>tl'] = { '<cmd>TestLast<CR>', { desc = 'Test Last' } },
    ['<leader>tn'] = { '<cmd>TestNearest<CR>', { desc = 'Test Nearest' } },
    ['<leader>ts'] = { '<cmd>TestSuite<CR>', { desc = 'Test Suite' } },
    ['<leader>tv'] = { '<cmd>TestVisit<CR>', { desc = 'Visit Test File' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

M.config = function()
  vim.api.nvim_exec(
    [[
    function! DockerTransform(cmd)
      return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
    endfunction
  ]] ,
    false
  )

  vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')}]]
  vim.cmd [[ let test#transformation = 'docker']]
  vim.cmd [[ let g:test#basic#start_normal = 1 " If using basic strategy ]]
end

return M
