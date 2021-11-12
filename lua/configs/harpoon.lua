require('harpoon').setup {
  global_settings = {
    save_on_toggle = true,
    save_on_change = false,
    enter_on_sendcmd = true,
  },
}

require('which-key').register({
  h = {
    name = 'Harpoon',
    ['p'] = { '<cmd>lua require("harpoon.mark").add_file()<CR>', 'Add File' },
    ['a'] = { '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', 'Go to file 1' },
    ['s'] = { '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', 'Go to file 2' },
    ['d'] = { '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', 'Go to file 3' },
    ['f'] = { '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', 'Go to file 4' },
    ['q'] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', 'Quick Files Menu' },
    ['w'] = { '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', 'Quick Commands Menu' },
    ['t'] = { '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', 'Go to Terminal 1' },
    ['y'] = { '<cmd>lua require("harpoon.term").gotoTerminal(2)<CR>', 'Go to Terminal 2' },
  },
}, {
  prefix = '<leader>',
})
