local M = {}

M.config = function()
  require 'gitsigns'.setup {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next Hunk' })

      map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'Previous Hunk' })

      -- Actions
      map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
      map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })
      map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage Buffer' })
      map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Unstage Hunk' })
      map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
      map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview Hunk' })
      map('n', '<leader>ge', function() gs.blame_line { full = true } end, { desc = 'Blame Line' })
      map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'Toggle Line Blame' })
      map('n', '<leader>gd', gs.diffthis, { desc = 'Diff File' })
      map('n', '<leader>gD', function() gs.diffthis '~' end, { desc = 'Diff Index' })
      map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'Toggle Deleted' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select Hunk' })
    end,
  }
end

return M
