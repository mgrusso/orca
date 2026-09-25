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

## Installation Methods

### Method 1: System Extension (`systemd-sysext`) — Recommended for Dakota

Dakota enforces kernel `fs-verity` on all ComposeFS layers, which prevents custom OCI image rebase via `bootc switch`. The intended, non-destructive extension method is `systemd-sysext`:

```bash
# 1. Download the sysext raw image into extensions directory
sudo mkdir -p /var/lib/extensions
sudo curl -L -o /var/lib/extensions/orca.raw https://github.com/mgrusso/orca/releases/download/v0.1.0/orca.raw

# 2. Enable automatic extension mounting on boot
sudo systemctl enable systemd-sysext

# 3. Activate extension immediately (no reboot required!)
sudo systemd-sysext refresh
```

To configure your user dotfiles:
```bash
mkdir -p ~/.config/{niri,noctalia,ghostty,hypr}
curl -sSL https://raw.githubusercontent.com/mgrusso/orca/main/system_files/etc/skel/.config/niri/config.kdl -o ~/.config/niri/config.kdl
curl -sSL https://raw.githubusercontent.com/mgrusso/orca/main/system_files/etc/skel/.config/noctalia/config.toml -o ~/.config/noctalia/config.toml
curl -sSL https://raw.githubusercontent.com/mgrusso/orca/main/system_files/etc/skel/.config/ghostty/config -o ~/.config/ghostty/config
curl -sSL https://raw.githubusercontent.com/mgrusso/orca/main/system_files/etc/skel/.config/hypr/hyprland.conf -o ~/.config/hypr/hyprland.conf
```

Log out of your current session, click the gear icon on the GDM login screen, and select **Orca (Niri)**.

---

### Method 2: Bootc Rebase (Standard Bluefin / Fedora Silverblue)

On a standard Bluefin or Fedora Silverblue (Atomic) system:

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

