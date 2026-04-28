-- See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")

-- hl.env("LIBVA_DRIVER_NAME", "nvidia")
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GDK_SCALE", "1")
hl.env("__GL_VRR_ALLOWED", "0")

hl.env("AQ_DRM_DEVICES", "$HOME/.config/hypr-cards/cardIntel:$HOME/.config/hypr-cards/cardNvidia")
hl.env("WLR_DRM_DEVICES", "$HOME/.config/hypr-cards/cardIntel:$HOME/.config/hypr-cards/cardNvidia")

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GSK_RENDERER", "ngl")

hl.env("ADW_DEBUG_COLOR_SCHEME", "prefer-dark")

hl.env("GTK_THEME", "Kanagawa-Dark-Dragon")
hl.env("EDITOR", "nvim")

hl.env("EDGE_PATH", "/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome")
hl.env("CHROME_PATH", "/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome")

-- hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("LC_CTYPE", "pt_BR.UTF-8")
