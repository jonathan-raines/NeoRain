local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add {
  source = 'ibhagwan/fzf-lua',
  dependencies = { "echasnovski/mini.icons" }
}

later(function()
  require 'fzf-lua'.setup {
    winopts = { height = 0.6, row = 1.0, col = 0.0 },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      }
    },
    oldfiles = {
      -- In Telescope, when I used <leader>fr, it would load old buffers.
      -- fzf lua does the same, but by default buffers visited in the current
      -- session are not included. I use <leader>fr all the time to switch
      -- back to buffers I was just in. If you missed this from Telescope,
      -- give it a try.
      include_current_session = true,
    },
    previewers = {
      builtin = {
        -- fzf-lua is very fast, but it really struggled to preview a couple files
        -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
        -- It turns out it was Treesitter having trouble parsing the files.
        -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
        -- (Yes, I know you shouldn't have 100KB minified files in source control.)
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    }
  }

  require("fzf-lua").register_ui_select()

  vim.api.nvim_create_user_command('Todos', function()
    require('fzf-lua').grep { search = [[TODO:|todo!\(.*\)]], no_esc = true }
  end, { desc = 'Grep TODOs', nargs = 0 })

  local keymaps = {
    { 'n', '<leader><leader>', vim.cmd.FzfLua,                                                 { desc = '[FzfLua] Pickers' } },
    { 'n', '<leader>fb',       function() vim.cmd.FzfLua 'buffers' end,                        { desc = '[FzfLua] Buffers' } },
    { 'n', '<leader>fc',       function() vim.cmd.FzfLua 'colorschemes' end,                   { desc = '[FzfLua] Colorschemes' } },
    { 'n', '<leader>fd',       function() vim.cmd.FzfLua 'lsp_document_diagnostics' end,       { desc = 'Document diagnostics' } },
    { 'n', '<leader>fD',       function() vim.cmd.FzfLua 'lsp_workspace_diagnostics' end,      { desc = 'Workspace diagnostics' } },
    { 'n', '<leader>ff',       function() vim.cmd.FzfLua 'files' end,                          { desc = '[FzfLua] Find Files' } },
    { 'n', '<leader>fh',       function() vim.cmd.FzfLua 'git_status' end,                     { desc = '[FzfLua] Git Status' } },
    { 'n', '<leader>fo',       function() require('fzf-lua').oldfiles { cwd_only = true } end, { desc = '[FzfLua] Old Files' } },
    { 'n', '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                         { desc = '[FzfLua] Resume' } },
    { 'n', '<leader>ft',       function() vim.cmd.FzfLua 'tabs' end,                           { desc = '[FzfLua] Tabs' } },
    { 'n', '<leader>fw',       function() vim.cmd.FzfLua 'grep_cword' end,                     { desc = '[FzfLua] Grep Word' } },
    { 'n', '<leader>fW',       function() vim.cmd.FzfLua 'grep_cWORD' end,                     { desc = '[FzfLua] Grep WORD' } },
    { 'n', '<leader>f/',       function() vim.cmd.FzfLua 'blines' end,                         { desc = '[FzfLua] Grep Buffer' } },
    { 'n', '<leader>/',        function() vim.cmd.FzfLua 'live_grep_native' end,               { desc = '[FzfLua] Live Grep' } },
  }

  for _, val in pairs(keymaps) do
    vim.keymap.set(val[1], val[2], val[3], vim.tbl_extend('force', {}, val[4]))
  end
end)
