local wezterm = require 'wezterm'
local config = {}

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[2]

config.window_close_confirmation = 'NeverPrompt'
config.default_cursor_style = 'SteadyBar'
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 23
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13
config.check_for_updates = false
config.audible_bell = 'Disabled'
config.hide_mouse_cursor_when_typing = false
config.show_tab_index_in_tab_bar = false
config.window_decorations = 'RESIZE'
config.font = wezterm.font 'JetBrains Mono'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if window:is_focused() then
    overrides.colors = {
      tab_bar = {
        background = '#303030',
        active_tab = {
          bg_color = '#444444',
          fg_color = '#deddda'
        },
        inactive_tab = {
          bg_color = '#303030',
          fg_color = '#deddda'
        },
        inactive_tab_hover = {
          bg_color = '#303030',
          fg_color = '#deddda'
        }
      },
      foreground = '#deddda',
      background = '#1d1d1d',
      cursor_border = '#9a9996',
      cursor_bg = '#9a9996',
      cursor_fg = '#1d1d1d',
      selection_bg = '#193d66',
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
    overrides.colors = {
      tab_bar = {
        background = '#2a2a2a',
        active_tab = {
          bg_color = '#3f3f3f',
          fg_color = '#deddda'
        },
        inactive_tab = {
          bg_color = '#2a2a2a',
          fg_color = '#deddda'
        },
        inactive_tab_hover = {
          bg_color = '#2a2a2a',
          fg_color = '#deddda'
        }
      },
      foreground = '#deddda',
      background = '#1d1d1d',
      cursor_border = '#9a9996',
      cursor_bg = '#9a9996',
      cursor_fg = '#1d1d1d',
      selection_bg = '#193d66',
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
