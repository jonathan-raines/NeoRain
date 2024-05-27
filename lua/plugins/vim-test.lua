return {
  'vim-test/vim-test',
  init = function()
    vim.cmd
    [[ function! DockerTransform(cmd)
        return "docker compose exec $(tmux display-message -p '#S') " .a:cmd
       endfunction
    ]]

    vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')} ]]
    vim.cmd [[ let test#transformation = 'docker' ]]
    -- vim.cmd [[ let test#basic#start_normal = 1 ]]
  end,
  keys = {
    { '<leader>tf', vim.cmd.TestFile,    desc = 'Test File' },
    { '<leader>tl', vim.cmd.TestLast,    desc = 'Test Last' },
    { '<leader>tn', vim.cmd.TestNearest, desc = 'Test Nearest' },
    { '<leader>ts', vim.cmd.TestSuite,   desc = 'Test Suite' },
    { '<leader>tv', vim.cmd.TestVisit,   desc = 'Test Visit' },
  },
}
