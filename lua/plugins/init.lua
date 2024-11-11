return {
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {},
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<c-\\>",     function() Snacks.terminal() end,                desc = "Toggle Terminal" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference" },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    }
  }
}
