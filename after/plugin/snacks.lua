MiniDeps.add { source = 'folke/snacks.nvim' }

MiniDeps.later(function()
  require 'snacks'.setup {
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = {
      win = {
        input = {
          keys = {
            ["<c-t>"] = { "edit_tab", mode = { "i", "n" } }
          }
        }
      }
    }
  }

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Git                                 │
  --  ╰─────────────────────────────────────────────────────────╯
  vim.keymap.set('n', "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Log" })
  vim.keymap.set('n', '<leader>gf', function() Snacks.lazygit.log_file() end, { desc = 'Lazygit Current File History' })
  vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })
  vim.keymap.set('n', '<leader>gl', function() Snacks.lazygit.log() end, { desc = 'Lazygit Log (cwd)' })
  vim.keymap.set('n', "<leader>fh", function() Snacks.picker.git_status() end, { desc = "Git Status" })
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     LSP                                 │
  --  ╰─────────────────────────────────────────────────────────╯
  vim.keymap.set('n', "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
  vim.keymap.set('n', "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
  vim.keymap.set('n', "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
  vim.keymap.set('n', "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Picker                              │
  --  ╰─────────────────────────────────────────────────────────╯
  vim.keymap.set('n', '<leader><space>', function() Snacks.picker() end, { desc = 'Pickers' })
  vim.keymap.set('n', "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
  vim.keymap.set('n', "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
  vim.keymap.set('n', "<leader>f/", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
  vim.keymap.set('n', "<leader>bl", function() Snacks.picker.buffers() end, { desc = "Buffers" })
  vim.keymap.set('n', "<leader>fb", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
  vim.keymap.set('n', "<leader>fc", function() Snacks.picker.commands() end, { desc = "Commands" })
  vim.keymap.set('n', '<leader>ff', function() Snacks.picker.files() end, { desc = 'Files' })
  vim.keymap.set('n', "<leader>fo", function()
    Snacks.picker.recent { filter = { cwd = vim.fn.getcwd() } }
  end, { desc = "Recent" })
  vim.keymap.set('n', "<leader>fr", function() Snacks.picker.resume() end, { desc = "Resume" })
  vim.keymap.set({ "n", "x" }, "<leader>fw", function() Snacks.picker.grep_word() end,
    { desc = "Visual selection or word" })
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Terminal                            │
  --  ╰─────────────────────────────────────────────────────────╯
  vim.keymap.set('n', '<c-/>', function() Snacks.terminal() end, { desc = 'Toggle Terminal' })
end)
