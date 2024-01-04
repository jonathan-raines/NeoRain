return {
  "ThePrimeagen/harpoon",
  dependencies = "nvim-lua/plenary.nvim",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      }
    }

    vim.keymap.set("n", "<leader>gm", function() harpoon:list():append() end, { desc = 'Harpoon Mark' })
    vim.keymap.set("n", "<leader>gg",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      { desc = 'Harpoon Menu' }
    )

    for i = 1, 9, 1 do
      print(i)
      vim.keymap.set("n", "<leader>g" .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon Select ' .. i })
    end

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>gp", function() harpoon:list():prev() end, { desc = 'Harpoon Prev Buf' })
    vim.keymap.set("n", "<leader>gn", function() harpoon:list():next() end, { desc = 'Harpoon Next Buf' })
  end,
  keys = { "<leader>g" }
}
