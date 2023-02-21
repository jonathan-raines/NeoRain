return {
  {
    'otavioschwanck/ruby-toolkit.nvim', dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects" },
    ft = 'ruby',
    keys = {
      { "<leader>mv", "<cmd>lua require('ruby-toolkit').extract_variable()<CR>",          desc = "Extract Variable",                   mode = { "v" } },
      { "<leader>mf", "<cmd>lua require('ruby-toolkit').extract_to_function()<CR>",       desc = "Extract To Function",                mode = { "v" } },
      { "<leader>mf", "<cmd>lua require('ruby-toolkit').create_function_from_text()<CR>", desc = "Create Function from item on cursor" },
    }
  },
}
