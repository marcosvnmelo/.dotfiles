local opacity = 0.8

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--
--     border_size = 0,
--     rounding    = 0,
-- })

hl.window_rule({
	name = "no-gaps-f1",
	match = {
		float = false,
		workspace = "f[1]",
	},

	border_size = 0,
	rounding = 0,
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })

hl.layer_rule({
	match = { namespace = "swaync-notification-window" },
	-- blur = true,
	-- ignore_alpha = 0,
	-- ignore_alpha = 0.5,
	dim_around = true,
})

hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	-- blur = true,
	-- ignore_alpha = 0,
	-- ignore_alpha = 0.5,
	dim_around = true,
})

hl.layer_rule({
	match = { namespace = "rofi" },
	-- blur = true,
	-- ignore_alpha = 0,
	-- ignore_alpha = 0.9,
	dim_around = true,
})

-- blur
hl.layer_rule({
	name = "vicinae-blur",
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0,
})

-- disable animation for vicinae only
hl.layer_rule({
	name = "vicinae-no-animation",
	match = { namespace = "vicinae" },
	no_anim = true,
})

hl.window_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

-- windowrule = move (((monitor_w)-(window_w)-10) ((monitor_h)-(window_h)-10), match:title Picture(\s|-)in(\s|-)(p|P)icture, #match:workspace m[0]
-- windowrule = move 10 ((monitor_h)-(window_h)-10), match:title Picture(\s|-)in(\s|-)(p|P)icture, match:workspace m[1]
hl.window_rule({
	name = "float-picture-in-picture",
	match = { title = "Picture(\\s|-)in(\\s|-)(p|P)icture" },
	-- match = { workspace = "m[0]" },

	float = true,
	move = "((monitor_w)-(window_w)-10) ((monitor_h)-(window_h)-10)",
	size = "500 280",
	no_initial_focus = true,
	pin = true,
})

hl.window_rule({
	name = "full-width-column",
	match = { tag = "full_width_column" },

	maximize = true,
})

hl.window_rule({
	name = "float-xdg-desktop-portal-gtk",
	match = { class = "xdg-desktop-portal-gtk" },

	float = true,
	center = true,
	size = "870 600",
})

hl.window_rule({
	name = "float-file-roller",
	match = { class = "org.gnome.FileRoller", title = "Extract" },

	float = true,
	center = true,
	size = "870 600",
})

hl.window_rule({
	name = "float-bluetooth-control",
	match = { class = "blueman-manager" },

	float = true,
	monitor = 0,
	center = true,
	opacity = opacity,
})

hl.window_rule({
	name = "float-volume-control",
	match = { class = "org.pulseaudio.pavucontrol" },

	float = true,
	monitor = 0,
	center = true,
	opacity = opacity,
})

hl.window_rule({
	name = "float-wifi-connection-editor",
	match = { class = "nm-connection-editor" },

	float = true,
	monitor = 0,
	center = true,
})

hl.window_rule({
	name = "android-emulator",
	match = { class = "Emulator" },

	float = true,
	border_size = 2,
	no_blur = true,
	no_shadow = true,
	no_anim = true,
	opaque = true,
})

hl.window_rule({
	name = "android-emulator-rounding",
	match = { class = "Emulator", title = "^(Android Emulator -)(.*)$" },

	rounding = "30%",
	float = false,
	size = "445 100%",
})

-- React native dev tools
hl.window_rule({
	name = "react-native-dev-tools",
	match = { initial_class = "chrome-127.0.0.1__debugger-frontend_rn_fusebox.html-Default" },

	float = true,
	center = true,
	size = "870 600",
})

hl.window_rule({
	name = "float-guitarix",
	match = { class = "guitarix", title = "^(Guitarix:).*$" },

	float = true,
	center = true,
	size = "1600 840",
})

hl.window_rule({
	name = "float-fdm",
	match = { class = "fdm" },

	float = true,
	center = true,
	size = "1010 645",
})

hl.window_rule({
	name = "float-frog",
	match = { class = "com.github.tenderowl.frog" },

	float = true,
	center = true,
	size = "1010 645",
})

-- Special workspace apps
hl.window_rule({
	name = "chrome-pwa-whatsapp",
	match = { class = "chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default" },

	workspace = "special:whatsapp",
})
-- hl.window_rule({ workspace = "special:whatsapp", match = { class = "com.rtosta.zapzap" } })
hl.window_rule({ workspace = "special:vesktop", match = { class = "vesktop" } })

hl.window_rule({
	name = "betterbird",
	match = { class = "eu.betterbird.Betterbird" },

	workspace = "special:mail silent",
})
hl.window_rule({
	name = "betterbird-edit-dialog",
	match = { class = "eu.betterbird.Betterbird", initial_title = "Edit Item" },

	float = true,
	center = true,
	size = "1200 800",
})
hl.window_rule({
	name = "betterbird-reminder",
	match = { class = "eu.betterbird.Betterbird", title = "^(.*Reminder.*)$" },

	float = true,
	center = true,
	size = "1200 800",
	pin = true,
})

hl.window_rule({
	name = "whats-crab-dev",
	match = { class = "whats-crab" },

	monitor = 1,
})

-- Opacity rules
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, opacity = opacity })
hl.window_rule({ match = { class = "org.wezfurlong.wezterm" }, opacity = opacity })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, opacity = opacity })
hl.window_rule({ match = { class = "code" }, opacity = opacity })
hl.window_rule({ match = { class = "cursor" }, opacity = opacity })
hl.window_rule({ match = { class = "dev.zed.Zed" }, opacity = opacity })

-- local suppressMaximizeRule =
hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
