-- Last Example update: Apr 29, 2026
-- Commit: animations: add springs

------------------
---- MONITORS ----
------------------

-- See https://wiki.hyprland.org/Configuring/Monitors/
require("monitors")

--------------------
---- WORKSPACES ----
--------------------

require("workspaces")

-------------------
---- AUTOSTART ----
-------------------

require("autostart")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Replaced by uwsm
-- require('env')

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------

require("style")

---------------
---- INPUT ----
---------------

require("input")

---------------------
---- KEYBINDINGS ----
---------------------

require("keybinds")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

require("windows")
