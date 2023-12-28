return {
  "ThePrimeagen/harpoon",
  dependencies = "nvim-lua/plenary.nvim",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>gm", function() harpoon:list():append() end, { desc = 'Harpoon Mark' })
    vim.keymap.set("n", "<leader>gg", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = 'Harpoon Menu' })

    vim.keymap.set("n", "<leader>gj", function() harpoon:list():select(1) end, { desc = 'Harpoon Select 1' })
    vim.keymap.set("n", "<leader>gk", function() harpoon:list():select(2) end, { desc = 'Harpoon Select 2' })
    vim.keymap.set("n", "<leader>gl", function() harpoon:list():select(3) end, { desc = 'Harpoon Select 3' })
    vim.keymap.set("n", "<leader>g;", function() harpoon:list():select(4) end, { desc = 'Harpoon Select 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>gp", function() harpoon:list():prev() end, { desc = 'Harpoon Prev Buf' })
    vim.keymap.set("n", "<leader>gn", function() harpoon:list():next() end, { desc = 'Harpoon Next Buf' })
  end,
  event = 'VeryLazy'
}
