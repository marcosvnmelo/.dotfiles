# Dotfiles

Run `./install.sh` to install all enabled modules, or `./install.sh <module>` to install a specific module only.

# Post install

After the installation, it's recommended to follow this post install steps to better experience.

## General

### Increase max user watches ([source](https://github.com/erik1066/pop-os-setup?tab=readme-ov-file#increase-the-inotify-watch-count))

When working on large projects, prevents the following error: "User limit of inotify watches reached".

1. Edit the `/etc/sysctl.conf` file
2. Add or edit the property `fs.inotify.max_user_watches` to `10000000`
3. Run `sudo sysctl -p` (or restart the OS)

### Fix Windows time (dual boot)

If you have dual boot with Windows and every time you boot in, it shows the wrong time, run the following command on linux:

```bash
timedatectl set-local-rtc 1
```

## Pop!\_OS 22.04

### Improve font rendering ([source](https://github.com/erik1066/pop-os-setup?tab=readme-ov-file#improve-font-rendering))

The default font rendering in Pop!\_OS may appear blurry on
LCD monitors. Gnome's OS settings application lacks the ability to
change font rendering. You must install the Gnome Tweak Tool to adjust
these settings. Gnome Tweak Tool can be installed from the Pop!\_Shop or
from a terminal as shown below:

1. Run `sudo apt install gnome-tweaks`
2. Run `gnome-tweaks`
3. **Fonts** > **Hinting** > Set to "Full"
4. **Fonts** > **Antialiasing** > Set to "Subpixel (for LCD screens)"

> The Pop!\_OS defaults are: "Slight" for Hinting and "Standard" for Antialiasing, in case you want to switch back.

### Enable Wayland

X11 is the default and most compatible option, but can lead to poor experience when dealing with high resolution monitors.
Wayland it's a new and more performative alternative, and can be enabled with the following steps:

- Set `WaylandEnable=true` in `/etc/gdm3/custom.conf`
- Restart the OS
- At the log in screen, after select the user, there will be a small gear wheel on the bottom right side, choose **Pop on Wayland** instead of **Pop**

## Arch linux

### Enable gnome-keyring ([source](https://stackoverflow.com/a/66480029))

In GDM+GNOME, when you login, GNOME Keyring is automatically unlocked. However, it doesn't do so in SDDM+(KDE/Hyprland). When you start some GNOME or Electron application like VS Code, they ask you to type the login password again or just froze.

The solution is to edit /etc/pam.d/sddm and add pam_gnome_keyring.so like this (the second line and last line):

```sddm
#%PAM-1.0
auth     include        common-auth
auth     optional       pam_gnome_keyring.so
account  include        common-account
password include        common-password
session  required       pam_loginuid.so
session  include        common-session
session  optional       pam_gnome_keyring.so auto_start
```

This is a solution that I found here that should work for you. For me, the lines were already there, but I simply had to remove the - at the beginning of the lines.
