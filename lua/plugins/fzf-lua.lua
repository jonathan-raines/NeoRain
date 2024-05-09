return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'fzf-lua'.setup {
      winopts = {
        height = 0.6,
        row = 1.0,
        col = 0.0
      },
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept"
        }
      }
    }

    require("fzf-lua").register_ui_select()
  end,
  keys = {
    { '<leader><leader>', vim.cmd.FzfLua,                                                                     desc = '[FzfLua] Pickers' },
    { '<leader>fb',       function() vim.cmd.FzfLua 'buffers' end,                                            desc = '[FzfLua] Buffers' },
    { '<leader>ff',       function() vim.cmd.FzfLua 'files' end,                                              desc = '[FzfLua] Find Files' },
    { '<leader>fh',       function() vim.cmd.FzfLua 'git_status' end,                                         desc = '[FzfLua] Git Status' },
    { '<leader>fk',       function() vim.cmd.FzfLua 'keymaps' end,                                            desc = '[FzfLua] Keymaps' },
    { '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                                             desc = '[FzfLua] Resume' },
    { '<leader>fo',       function() require('fzf-lua').oldfiles { cwd_only = true } end,                     desc = '[FzfLua] Old Files' },
    { '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                                             desc = '[FzfLua] Resume' },
    { '<leader>ft',       function() vim.cmd.FzfLua 'tabs' end,                                               desc = '[FzfLua] Tabs' },
    { '<leader>fw',       function() vim.cmd.FzfLua 'grep_cword' end,                                         desc = '[FzfLua] Grep Word' },
    { '<leader>fW',       function() vim.cmd.FzfLua 'grep_cWORD' end,                                         desc = '[FzfLua] Grep WORD' },
    { '<leader>f/',       function() vim.cmd.FzfLua 'lgrep_curbuf' end,                                       desc = '[FzfLua] Search Buffer' },
    { '<leader>/',        function() vim.cmd.FzfLua 'live_grep_native' end,                                   desc = '[FzfLua] Live Grep' },
    -- LSP keymaps
    { '<leader>ld',       function() require("fzf-lua").lsp_definitions { jump_to_single_result = true } end, desc = '[FzfLua] LSP Definitions' },
    { '<leader>lr',       function() vim.cmd.FzfLua 'lsp_references' end,                                     desc = '[FzfLua] LSP References' },
    { '<leader>ls',       function() vim.cmd.FzfLua 'lsp_document_symbols' end,                               desc = '[FzfLua] Document Symbols' },
    { '<leader>lS',       function() vim.cmd.FzfLua 'lsp_workspace_symbols' end,                              desc = '[FzfLua] Workspace Symbols' },
  }
}
