require('harpoon').setup {
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
  },
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
    ['t'] = { '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', 'Go to Terminal' },
  },
}, {
  prefix = '<leader>',
})
