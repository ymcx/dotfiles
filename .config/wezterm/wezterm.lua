local wezterm = require 'wezterm'
local config = {}

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[2]
-- config.window_decorations = 'NONE'
config.window_decorations = 'RESIZE'

config.default_cursor_style = 'SteadyBar'
config.window_close_confirmation = 'NeverPrompt'
config.show_new_tab_button_in_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13
config.check_for_updates = false
config.audible_bell = 'Disabled'
config.hide_mouse_cursor_when_typing = false
config.show_tab_index_in_tab_bar = false
config.force_reverse_video_cursor = true
config.font = wezterm.font 'JetBrains Mono'

config.window_padding = {
  left = 6,
  right = 6,
  top = 2,
  bottom = 2
}

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if window:is_focused() then
    overrides.window_frame = {
      font = wezterm.font 'Cantarell',
      active_titlebar_bg = '#303030',
      inactive_titlebar_bg = '#303030',
      font_size = 11
    }
    overrides.colors = {
      tab_bar = {
        inactive_tab_edge = '#4f4f4f',
        active_tab = {
          bg_color = '#444444',
          fg_color = '#ffffff'
        },
        inactive_tab = {
          bg_color = '#303030',
          fg_color = '#ffffff'
        },
        inactive_tab_hover = {
          bg_color = '#303030',
          fg_color = '#ffffff'
        }
      },
      foreground = '#ffffff',
      background = '#1d1d1d',
      selection_fg = '#1d1d1d',
      selection_bg = '#ffffff',
      ansi = {
        '#241f31',
        '#c01c28',
        '#2ec27e',
        '#f5c211',
        '#1e78e4',
        '#9841bb',
        '#0ab9dc',
        '#c0bfbc'
      },
      brights = {
        '#5e5c64',
        '#ed333b',
        '#57e389',
        '#f8e45c',
        '#51a1ff',
        '#c061cb',
        '#4fd2fd',
        '#f6f5f4'
      }
    }
  else
    overrides.window_frame = {
      font = wezterm.font 'Cantarell',
      active_titlebar_bg = '#242424',
      inactive_titlebar_bg = '#242424',
      font_size = 11
    }
    overrides.colors = {
      tab_bar = {
        inactive_tab_edge = '#343434',
        active_tab = {
          bg_color = '#2f2f2f',
          fg_color = '#919191'
        },
        inactive_tab = {
          bg_color = '#242424',
          fg_color = '#919191'
        },
        inactive_tab_hover = {
          bg_color = '#242424',
          fg_color = '#919191'
        }
      },
      foreground = '#ffffff',
      background = '#1d1d1d',
      selection_fg = '#1d1d1d',
      selection_bg = '#ffffff',
      ansi = {
        '#241f31',
        '#c01c28',
        '#2ec27e',
        '#f5c211',
        '#1e78e4',
        '#9841bb',
        '#0ab9dc',
        '#c0bfbc'
      },
      brights = {
        '#5e5c64',
        '#ed333b',
        '#57e389',
        '#f8e45c',
        '#51a1ff',
        '#c061cb',
        '#4fd2fd',
        '#f6f5f4'
      }
    }
  end
  window:set_config_overrides(overrides)
end)

return config
