return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>gm", function() harpoon:list():append() end)
      vim.keymap.set("n", "<leader>gg", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>gj", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>gk", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>gl", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>g;", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>gp", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<leader>gn", function() harpoon:list():next() end)
    end,
    keys = {
      '<leader>g'
    }
}
