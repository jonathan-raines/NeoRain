local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'otavioschwanck/arrow.nvim' }

later(function()
  require 'arrow'.setup {
    -- s Toggle Current         v Open Vertical         d Delete mode        q Quit
    -- e Edit Arrow File        - Open Horizontal       C Clear All Items
    show_icons = true,
    leader_key = '<leader>a',
    buffer_leader_key = '<leader>m',
    separate_by_branch = true, -- Bookmarks will be separated by git branch
    hide_handbook = true,
    always_show_path = false
  }
end)
