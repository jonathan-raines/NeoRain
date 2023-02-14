return {
  'vim-test/vim-test',
  config = function()
    vim.cmd
    [[ function! DockerTransform(cmd)
        return "docker-compose exec $(tmux display-message -p '#S') " .a:cmd
       endfunction
    ]]

    local tt = require 'toggleterm'
    local ttt = require 'toggleterm.terminal'

    vim.g['test#custom_strategies'] = {
      tterm = function(cmd)
        tt.exec(cmd)
      end,
      tterm_close = function(cmd)
        local term_id = 0
        tt.exec(cmd, term_id)
        ttt.get_or_create_term(term_id):close()
      end,
    }

    vim.cmd [[ let test#custom_transformations = {'docker': function('DockerTransform')} ]]
    vim.g['test#transformation'] = 'docker'
    -- vim.g['test#basic#start_normal'] = 1
    vim.g['test#strategy'] = 'tterm'
  end,
  keys = {
    { '<leader>tf', vim.cmd.TestFile,    desc = 'Test File' },
    { '<leader>tl', vim.cmd.TestLast,    desc = 'Test Last' },
    { '<leader>tn', vim.cmd.TestNearest, desc = 'Test Nearest' },
    { '<leader>ts', vim.cmd.TestSuite,   desc = 'Test Suite' },
    { '<leader>tv', vim.cmd.TestVisit,   desc = 'Test Visit' },
  },
}
