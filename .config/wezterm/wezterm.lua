local wezterm = require 'wezterm'
local config = {}

-- local gpus = wezterm.gui.enumerate_gpus()
-- config.webgpu_preferred_adapter = gpus[2]

-- config.window_close_confirmation = 'NeverPrompt'
-- config.default_cursor_style = 'SteadyBlock'
-- config.cursor_blink_ease_in = 'Constant'
-- config.cursor_blink_ease_out = 'Constant'
-- config.cursor_blink_rate = 600
-- config.detect_password_input = false

config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 23
config.use_fancy_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13
config.check_for_updates = false
config.audible_bell = 'Disabled'
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = false
config.show_tab_index_in_tab_bar = false
config.window_decorations = 'RESIZE'
config.font = wezterm.font 'JetBrains Mono'

config.window_padding = {
  left = 6,
  right = 6,
  top = 2,
  bottom = 2
}

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Light' then
    config.window_frame = {
      active_titlebar_bg = '#ffffff',
      inactive_titlebar_bg = '#ffffff'
    }
    config.colors = {
      tab_bar = {
        inactive_tab_edge = '#ffffff',
        active_tab = {
          bg_color = '#ebebeb',
          fg_color = '#000000'
        },
        inactive_tab = {
          bg_color = '#ffffff',
          fg_color = '#000000'
        },
        inactive_tab_hover = {
          bg_color = '#f1f1f1',
          fg_color = '#000000'
        },
        new_tab = {
          bg_color = '#ffffff',
          fg_color = '#000000'
        },
        new_tab_hover = {
          bg_color = '#f1f1f1',
          fg_color = '#000000'
        }
      },
      foreground = '#000000',
      background = '#ffffff',
      cursor_border = '#000000',
      selection_bg = '#000000',
      selection_fg = '#ffffff',
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
    config.window_frame = {
      active_titlebar_bg = '#303030',
      inactive_titlebar_bg = '#303030'
    }
    config.colors = {
      tab_bar = {
        inactive_tab_edge = '#303030',
        active_tab = {
          bg_color = '#444444',
          fg_color = '#ffffff'
        },
        inactive_tab = {
          bg_color = '#303030',
          fg_color = '#ffffff'
        },
        inactive_tab_hover = {
          bg_color = '#3f3f3f',
          fg_color = '#ffffff'
        },
        new_tab = {
          bg_color = '#303030',
          fg_color = '#ffffff'
        },
        new_tab_hover = {
          bg_color = '#3f3f3f',
          fg_color = '#ffffff'
        }
      },
      foreground = '#ffffff',
      background = '#1e1e1e',
      cursor_border = '#ffffff',
      selection_bg = '#ffffff',
      selection_fg = '#1e1e1e',
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
end

scheme_for_appearance(get_appearance())

return config
