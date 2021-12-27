local status_ok, spotify = pcall(require, 'nvim-spotify')
if not status_ok then
  return
end

spotify.setup {
  status = {
    update_interval = 10000, -- the interval (ms) to check for what's currently playing
    format = '%s %t by %a', -- spotify-tui --format argument
  },
}
