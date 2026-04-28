-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	-- NOTE: Run only for Hyprland without uwsm
	-- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	-- hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- hl.exec_cmd("uwsm-app waybar")
	-- hl.exec_cmd("uwsm-app swaync")
	hl.exec_cmd("uwsm-app -- qs -c noctalia-shell")

	-- NOTE: Run only for Hyprland
	-- hl.exec_cmd("systemctl --user start hyprpaper.service")
	-- hl.exec_cmd("systemctl --user start hypridle.service")

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("fcitx5 -d")

	hl.exec_cmd("uwsm-app -p 'After=arrpc.service' -- flatpak run dev.vencord.Vesktop")
	hl.exec_cmd(
		"uwsm-app -- ~/.local/share/applications/com.google.Chrome.flextop.chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop"
	)
	hl.exec_cmd("uwsm-app -- flatpak run eu.betterbird.Betterbird")
end)
