return {
  "folke/ts-comments.nvim",
  opts = {},
  event = { "BufRead", "BufNewFile" },
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
