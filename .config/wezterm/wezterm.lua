local wezterm = require 'wezterm'
local config = {}

-- config.window_decorations = 'NONE'
config.window_decorations = 'RESIZE'

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 600
config.show_new_tab_button_in_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.font_size = 13
config.hide_mouse_cursor_when_typing = false
config.show_tab_index_in_tab_bar = false
config.force_reverse_video_cursor = true
config.font = wezterm.font 'JetBrains Mono'

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

wezterm.on('window-focus-changed', function(window, pane)
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
          bg_color = '#303030',
          fg_color = '#ffffff'
        }
      },
      foreground = '#ffffff',
      background = '#1e1e1e',
      cursor_border = '#ffffff',
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
    overrides.window_frame = {
      font = wezterm.font 'Cantarell',
      active_titlebar_bg = '#242424',
      inactive_titlebar_bg = '#242424',
      font_size = 11
    }
    overrides.colors = {
      tab_bar = {
        inactive_tab_edge = '#242424',
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
      background = '#1e1e1e',
      cursor_border = '#ffffff',
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

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return string.gsub(tab.active_pane.title, '(.)%s*', '%1') .. ' - WezTerm'
end)

return config
