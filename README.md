# Orca 🐋

A customized, immutable (atomic/bootc) operating system image based on **Project Bluefin Dakota**, preconfigured with modern tiling window managers (**Niri** & **Hyprland**), **Noctalia Shell**, the **Ghostty** terminal, and a unified dark theme.

---

## Highlights

* 🌊 **Bluefin Core:** Retains all benefits of Bluefin (Homebrew, Flatpak, `ujust`, Intel hardware acceleration, automatic system updates).
* 🪟 **Tiling Window Managers:**
  * **Niri (Default):** Smooth, continuous scroll-tiling — ideal for laptop trackpads with 1:1 touch gestures.
  * **Hyprland:** Dynamic tiling with fluid animations available as an alternative session on the login screen.
* 🐚 **Noctalia Shell:** Integrated control center, launcher, status bar, and notification daemon.
* ⚡ **Laptop Power Management:** Full native integration with `power-profiles-daemon` & UPower (toggle power profiles directly from Noctalia Quick Settings).
* 📁 **Desktop Convenience:** Nautilus (GNOME Files), automatic mounting of external drives (`gvfs`/`udisks2`), and Polkit-GNOME dialogs.
* 🎨 **Unified Theming:** Cohesive *Catppuccin Mocha / Deep Ocean* color palette across Ghostty, Noctalia Shell, Niri, and GTK/Adwaita.

---

## Keyboard Shortcuts (Niri & Hyprland)

| Shortcut | Action |
|---|---|
| `Super + Return` or `Super + T` | Open Ghostty terminal |
| `Super + Space` or `Super + D` | Toggle Noctalia app launcher (GNOME/Dakota feel) |
| `Super + C` | Toggle Noctalia control center (Wi-Fi, brightness, power profiles) |
| `Super + N` | Toggle Notifications panel |
| `Super + E` | Open Nautilus file manager |
| `Super + Q` | Close focused window |
| `Super + F` | Maximize window / column |
| `Super + 1..5` | Switch to workspace 1–5 |
| `Super + Shift + 1..5` | Move window / column to workspace 1–5 |
| `Media / Fn Keys` | Control volume, display brightness, and media playback |

---

## Installation & Switch
 
Run the following commands on your laptop (bootc-enabled system like Bluefin or Fedora Silverblue):
 
```bash
# 1. Check current deployment status
sudo bootc status

# 2. Switch to your Orca image
sudo bootc switch ghcr.io/mgrusso/orca:latest

# 3. Reboot into Orca
sudo systemctl reboot
```

> [!TIP]
> **Rollback Protection:**
> Because Orca is an immutable bootc image, your previous deployment remains available as a fallback in the boot menu. You can roll back at any time with `sudo bootc rollback`.

