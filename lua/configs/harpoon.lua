require('harpoon').setup {
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = true,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { 'harpoon' },
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
    ['T'] = { '<cmd>lua require("harpoon.tmux").gotoTerminal(1)<CR>', 'Go to Tmux Terminal 1' },
    ['Y'] = { '<cmd>lua require("harpoon.tmux").gotoTerminal(2)<CR>', 'Go to Tmux Terminal 2' },
  },
}, {
  prefix = '<leader>',
})

require('telescope').load_extension 'harpoon'
