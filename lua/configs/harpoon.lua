require('harpoon').setup {
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

require('which-key').register({
  j = {
    name = 'Harpoon',
    ['p'] = { '<cmd>lua require("harpoon.mark").add_file()<CR>', 'Add File' },
    ['a'] = { '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', 'Go to file 1' },
    ['s'] = { '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', 'Go to file 2' },
    ['d'] = { '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', 'Go to file 3' },
    ['f'] = { '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', 'Go to file 4' },
    ['q'] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Quick Menu' },
  },
}, opts)
