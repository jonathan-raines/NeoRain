return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup {
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
        },
      },
    }

    require("telescope").load_extension "file_browser"
  end,
  keys = {
    { '<leader>fe', '<cmd>Telescope file_browser<CR>', desc = 'File Browser' },
    { '<leader>fE', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>', desc = 'File Browser Relative' }
  }
}
