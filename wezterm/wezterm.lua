-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 11

config.window_background_opacity = 0.9
config.enable_wayland = false
config.window_decorations = "RESIZE"

config.hide_tab_bar_if_only_one_tab = true

config.force_reverse_video_cursor = true
config.color_scheme = "Kanagawa Dragon (Gogh)"

-- and finally, return the configuration to wezterm
return config
