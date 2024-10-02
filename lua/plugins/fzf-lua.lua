return {
  'ibhagwan/fzf-lua',
  config = function()
    require 'fzf-lua'.setup {
      winopts = { height = 0.6, row = 1.0, col = 0.0 },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        }
      }
    }

    require("fzf-lua").register_ui_select()

    vim.api.nvim_create_user_command('Todos', function()
      require('fzf-lua').grep { search = [[TODO:|todo!\(.*\)]], no_esc = true }
    end, { desc = 'Grep TODOs', nargs = 0 })
  end,
  keys = {
    { '<leader><leader>', vim.cmd.FzfLua,                                                 desc = '[FzfLua] Pickers' },
    { '<leader>fb',       function() vim.cmd.FzfLua 'buffers' end,                        desc = '[FzfLua] Buffers' },
    { '<leader>fd',       function() vim.cmd.FzfLua 'lsp_document_diagnostics' end,       desc = 'Document diagnostics' },
    { '<leader>fD',       function() vim.cmd.FzfLua 'lsp_workspace_diagnostics' end,      desc = 'Workspace diagnostics' },
    { '<leader>ff',       function() vim.cmd.FzfLua 'files' end,                          desc = '[FzfLua] Find Files' },
    { '<leader>fh',       function() vim.cmd.FzfLua 'git_status' end,                     desc = '[FzfLua] Git Status' },
    { '<leader>fo',       function() require('fzf-lua').oldfiles { cwd_only = true } end, desc = '[FzfLua] Old Files' },
    { '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                         desc = '[FzfLua] Resume' },
    { '<leader>ft',       function() vim.cmd.FzfLua 'tabs' end,                           desc = '[FzfLua] Tabs' },
    { '<leader>fw',       function() vim.cmd.FzfLua 'grep_cword' end,                     desc = '[FzfLua] Grep Word' },
    { '<leader>fW',       function() vim.cmd.FzfLua 'grep_cWORD' end,                     desc = '[FzfLua] Grep WORD' },
    { '<leader>f/',       function() vim.cmd.FzfLua 'grep_curbuf' end,                    desc = '[FzfLua] Grep Buffer' },
    { '<leader>/',        function() vim.cmd.FzfLua 'live_grep_native' end,               desc = '[FzfLua] Live Grep' },
  }
}
