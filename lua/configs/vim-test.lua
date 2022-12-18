local M = {}

M.setup = function()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  local keymaps = {
    ['<leader>tf'] = { vim.cmd.TestFile, { desc = 'Test File' } },
    ['<leader>tl'] = { vim.cmd.TestLast, { desc = 'Test Last' } },
    ['<leader>tn'] = { vim.cmd.TestNearest, { desc = 'Test Nearest' } },
    ['<leader>ts'] = { vim.cmd.TestSuite, { desc = 'Test Suite' } },
    ['<leader>tv'] = { vim.cmd.TestVisit, { desc = 'Visit Test File' } },
  }

  for key, val in pairs(keymaps) do
    keymap('n', key, val[1], vim.tbl_extend('keep', opts, val[2]))
  end
end

M.config = function()
  vim.cmd
  [[
    function! DockerTransform(cmd)
      return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
    endfunction
  ]]

  vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')} ]]
  vim.g['test#transformation'] = 'docker'
  vim.g['test#basic#start_normal'] = 1
end

return M
