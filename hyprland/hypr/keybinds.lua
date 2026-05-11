-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use
local uwsm = "uwsm-app -- "
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "rofi "
local dmenu = "vicinae "
local noctaliaIpc = "qs -c noctalia-shell ipc call "

-- See https://wiki.hyprland.org/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local shiftMod = mainMod .. "+ SHIFT"
local ctrlMod = mainMod .. "+ CTRL"

local scriptDir = "~/.dotfiles/hyprland/scripts"

-- Binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

-- NOTE: Terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(uwsm .. terminal))

-- NOTE: Session
-- hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(uwsm .. "hyprlock"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(noctaliaIpc .. "lockScreen lock"))
-- hl.bind(shiftMod .. " + Escape", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. "-show p -modi p:'rofi-power-menu' -config power"))
hl.bind(shiftMod .. " + Escape", hl.dsp.exec_cmd(noctaliaIpc .. "sessionMenu toggle"))

-- NOTE: File managers
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(uwsm .. terminal .. " --command=yazi"))
hl.bind(shiftMod .. " + E", hl.dsp.exec_cmd(uwsm .. fileManager))

-- NOTE: Noctalia
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(noctaliaIpc .. "settings toggle"))

-- NOTE: Messaging
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd( scriptDir .. "/scratchpad.sh whatsapp chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default gio launch ~/.local/share/applications/com.google.Chrome.flextop.chrome-hnpfjngllnobngcgfapefoaidbinmjnm-Default.desktop"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(scriptDir .. "/scratchpad.sh vesktop vesktop flatpak run dev.vencord.Vesktop"))

-- NOTE: Vicinae
hl.bind("ALT_L + Space", hl.dsp.exec_cmd(dmenu .. "vicinae://close || " .. dmenu .. "vicinae://open?popToRoot=true"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(dmenu .. "vicinae://launch/clipboard/history"))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(dmenu .. "vicinae://launch/core/search-emojis"))
-- TODO: create a extension to search nerdy icons
-- hl.bind(shiftMod .. " + Period", hl.dsp.exec_cmd("~/.config/rofi/scripts/nerdy.sh | vicinae dmenu -p \"Nerdy > \""))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.dotfiles/hyprland/dmenu/scripts/quick-actions.sh vicinae"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(dmenu .. "vicinae://launch/wm/switch-windows"))

-- NOTE: Mic
hl.bind(shiftMod .. " + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- NOTE: Hyprshot
local save_menu = " -o /tmp -s -- ~/.local/bin/save-temp-screenshot.sh"
hl.bind("Print", hl.dsp.exec_cmd(uwsm .. "hyprshot -m window" .. save_menu))
hl.bind("ALT_L + Print", hl.dsp.exec_cmd(uwsm .. "hyprshot -m window -m active" .. save_menu))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(uwsm .. "hyprshot -m region" .. save_menu))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(uwsm .. "hyprshot -m output" .. save_menu))

-- NOTE: Hyprpicker
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(uwsm .. "hyprpicker -a"))

-- NOTE: Paste
hl.bind(shiftMod .. " + V", hl.dsp.exec_cmd('sh -c "cliphist list | head -n 1 | cliphist decode | wtype -s 500 -d 50 -"'))

-- NOTE: Media control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })


hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- NOTE: Brightness control
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- NOTE: Scratchpads
-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- NOTE: Window manager
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.layout("colresize 1.0"))
hl.bind(ctrlMod .. " + M", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + F", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
-- hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("pkill -x fcitx5 || fcitx5"), { long_press = true, non_consuming = true })

hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))

hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind("ALT + SHIFT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall waybar || waybar"), { release = true }):set_enabled(false)
-- hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("qs -c noctalia-shell kill || qs -c noctalia-shell"), { release = true })

-- NOTE: Rofi
-- hl.bind("ALT_L + Space", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. ' -show drun -run-command '.. uwsm .. " {cmd}"))
-- hl.bind("ALT_L + SHIFT + Space", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. ' -show calc -modi calc -no-show-match -no-sort -config regular'))
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. ' -modi cliphist-rofi-img -show cliphist-rofi-img -show-icons -config regular'))
-- hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. '-modi "emoji,nerdy" -show emoji -config regular'))
hl.bind(shiftMod .. " + Period", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. '-modi "emoji,nerdy" -show nerdy -config regular'))
-- hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. '~/.dotfiles/hyprland/dmenu/scripts/quick-actions.sh rofi'))
-- hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("pkill -x " .. menu .. " || " .. uwsm .. menu .. '-modi "window" -show window'))

-- Move focus with mainMod + hjkl keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move active window around current workspace with shiftMod + hjkl keys
---@param direction 'left' | 'right' | 'up' | 'down'
---@return string
function moveActiveWindow(direction)
	local directionCoordinates = ""
  local directionLetter = direction:sub(1, 1)

	if direction == "left" then
		directionCoordinates = "{ x = -30, y = 0, relative = true, activewindow = true }"
	elseif direction == "right" then
		directionCoordinates = "{ x = 30, y = 0, relative = true, activewindow = true }"
	elseif direction == "up" then
		directionCoordinates = "{ y = -30, x = 0, relative = true, activewindow = true }"
	elseif direction == "down" then
		directionCoordinates = "{ y = 30, x = 0, relative = true, activewindow = true }"
	end

  local moveCommand = ""

  if direction == "left" or direction == "right" then
    moveCommand = "hyprctl dispatch 'hl.dsp.layout(\"swapcol " .. directionLetter .. "\")'"
  else
    moveCommand = "hyprctl dispatch 'hl.dsp.window.move({ direction = \"" .. directionLetter .. "\" })'"
  end

	return 'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch \'hl.dsp.window.move('
		.. directionCoordinates
		.. ")' || " .. moveCommand
end
hl.bind(shiftMod .. " + H", hl.dsp.exec_cmd(moveActiveWindow("left")))
hl.bind(shiftMod .. " + L", hl.dsp.exec_cmd(moveActiveWindow("right")))
hl.bind(shiftMod .. " + K", hl.dsp.exec_cmd(moveActiveWindow("up")))
hl.bind(shiftMod .. " + J", hl.dsp.exec_cmd(moveActiveWindow("down")))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with shiftMod + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mail special workspace
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(scriptDir .. "/scratchpad.sh mail eu.betterbird.Betterbird flatpak run eu.betterbird.Betterbird"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize windows
hl.bind(ctrlMod .. " + l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(ctrlMod .. " + h", hl.dsp.window.resize({ x = -30, y = 0, relative = true  }))
hl.bind(ctrlMod .. " + k", hl.dsp.window.resize({ x = 0, y = -30, relative = true  }))
hl.bind(ctrlMod .. " + j", hl.dsp.window.resize({ x = 0, y = 30, relative = true  }))
