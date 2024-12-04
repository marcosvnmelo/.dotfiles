-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12

config.default_prog = { "/usr/bin/fish", "-l" }

-- Pop!_OS
-- config.window_background_opacity = 0.9
-- config.enable_wayland = false
-- config.window_decorations = "RESIZE"

-- Arch Linux
config.enable_wayland = true
config.window_decorations = "NONE"

config.hide_tab_bar_if_only_one_tab = true

config.force_reverse_video_cursor = true
config.colors = {
	foreground = "#c5c9c5",
	background = "#181616",
	cursor_bg = "#C8C093",
	cursor_fg = "#C8C093",
	cursor_border = "#C8C093",
	selection_fg = "#C8C093",
	selection_bg = "#2D4F67",
	scrollbar_thumb = "#16161D",
	split = "#16161D",
	ansi = {
		"#0D0C0C",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#C8C093",
	},
	brights = {
		"#A6A69C",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C5",
	},
}

-- and finally, return the configuration to wezterm
return config
