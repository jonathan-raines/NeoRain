require('harpoon').setup {
  global_settings = {
    save_on_toggle = false,
    save_on_change = true,
    enter_on_sendcmd = true,
  },
}

require('which-key').register({}, opts)
