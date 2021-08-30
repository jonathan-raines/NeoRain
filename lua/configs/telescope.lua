require('telescope').setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      height = 0.9,
      preview_width = 80,
      width = 0.9,
    },
    mappings = {
      i = {},
      n = {},
    },
    pickers = {
      buffers = {
        sort_lastused = true
      },
      find_files = {
        hidden = true,
      },
    },
  },
}
