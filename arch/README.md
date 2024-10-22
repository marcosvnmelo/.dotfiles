# Arch linux

## DRM kernel mode setting ([source](https://wiki.hyprland.org/Nvidia/#drm-kernel-mode-setting))

Since NVIDIA does not load kernel mode setting by default, enabling it is required to make Wayland compositors function properly. To enable it, the NVIDIA driver modules need to be added to the initramfs.

Edit `/etc/mkinitcpio.conf`. In the `MODULES` array, add the following module names:

```conf
MODULES=(... nvidia nvidia_modeset nvidia_uvm nvidia_drm ...)
```

Then, create and edit `/etc/modprobe.d/nvidia.conf`. Add this line to the file:

```conf
options nvidia_drm modeset=1 fbdev=1
```

Lastly, rebuild the initramfs with `sudo mkinitcpio -P`, and reboot.

### Pacman hook ([source](https://wiki.archlinux.org/title/NVIDIA#pacman_hook))

A hook will be automatically copied to pacman hooks dir.
