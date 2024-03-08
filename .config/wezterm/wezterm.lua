local wezterm = require 'wezterm'
local config = {}

config.enable_tab_bar = false
config.default_cursor_style = 'SteadyBar'
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13
config.hide_mouse_cursor_when_typing = false
config.force_reverse_video_cursor = true
config.font = wezterm.font 'JetBrains Mono'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

config.color_scheme = 'OneHalfDark'

config.colors = {
  background = '#1e1e1e'
}

return config
