# Orca 🐋

A customized, immutable (atomic/bootc) operating system image based on **Project Bluefin**, preconfigured with modern tiling window managers (**Niri** & **Hyprland**), **Noctalia Shell**, the **Ghostty** terminal, and a unified Catppuccin dark aesthetic.

---

## Highlights

* 🌊 **Bluefin Core:** Retains all benefits of Bluefin (Homebrew, Flatpak, `ujust`, Intel/AMD hardware acceleration, automatic system updates).
* 🪟 **Tiling Window Managers:**
  * **Niri (Default):** Smooth, continuous scroll-tiling — ideal for laptop trackpads with 1:1 touch gestures.
  * **Hyprland:** Dynamic tiling with fluid animations available as an alternative session on the GDM login screen.
* 🐚 **Noctalia Shell:** Integrated control center, launcher, status bar, and notification daemon.
* 🖼️ **Native Bluefin Wallpapers:** Native Noctalia wallpaper integration loading official Bluefin artwork from `/usr/share/backgrounds/bluefin` with on-the-fly random switching via `Super + W`.
* ⚡ **Laptop Power Management:** Full native integration with `power-profiles-daemon` & UPower (toggle power profiles directly from Noctalia Quick Settings).
* 🔒 **Hardware-Bound Disk Encryption:** Full support for passwordless TPM2-backed LUKS unlocking via `ujust toggle-tpm2`.
* 📁 **Desktop Convenience:** Nautilus (GNOME Files), automatic mounting of external drives (`gvfs`/`udisks2`), and Polkit authentication dialogs.
* 📦 **Development Ready:** Out-of-the-box support for **Distrobox** container development and **Homebrew** (`/home/linuxbrew/.linuxbrew`, `ujust bbrew`).
* 🎨 **Unified Theming:** Cohesive *Catppuccin Mocha* & *Papirus-Dark* color palette across Ghostty, Noctalia Shell, Niri, and GTK/Libadwaita apps (with system-wide dark mode schema overrides).
* ⚙️ **Zero-Config Architecture:** System-wide defaults in `/etc/niri/` and `/etc/xdg/` — no manual copying of dotfiles required. Upstream improvements update automatically without masking user customizations.

---

## Keyboard Shortcuts (Niri)

| Shortcut | Action |
|---|---|
| `Super + Return` or `Super + T` | Open Ghostty terminal |
| `Super + Space` or `Super + D` | Toggle Noctalia app launcher |
| `Super + C` | Toggle Noctalia control center (Wi-Fi, brightness, power profiles) |
| `Super + N` | Toggle Notifications panel |
| `Super + W` | Cycle Bluefin wallpaper randomly on the fly |
| `Super + E` | Open Nautilus file manager |
| `Super + Q` | Close focused window |
| `Super + F` | Maximize window / column |
| `Super + Shift + F` | Fullscreen window |
| `Super + R` | Switch column width presets (33% / 50% / 66%) |
| `Super + Left/Right/Up/Down` or `H/J/K/L` | Navigate focus across columns and windows |
| `Super + 1..5` | Switch to workspace 1–5 |
| `Super + Shift + 1..5` | Move window / column to workspace 1–5 |
| `Super + Shift + E` | Quit Niri session |
| `Media / Fn Keys` | Volume control, display brightness, and media playback |

---

## Installation & Switch

On any bootc-enabled system (like standard Bluefin or Fedora Silverblue):

```bash
# 1. Check current deployment status
sudo bootc status

# 2. Switch to your Orca image
sudo bootc switch ghcr.io/mgrusso/orca:latest

# 3. Reboot into Orca
sudo systemctl reboot
```

After rebooting, select **Orca (Niri)** from the gear menu on the GDM login screen.

> [!TIP]
> **Rollback Protection:**
> Because Orca is an immutable bootc image, your previous deployment remains available as a fallback in the boot menu. You can roll back at any time with `sudo bootc rollback`.

---

## System Updates & Maintenance

Orca automatically stays up-to-date with upstream Bluefin security patches and Orca package updates.

* **Full System Update (Recommended):**
  ```bash
  ujust update
  ```
  Updates the base OS (`bootc`), Flatpaks, Homebrew formulas, Distrobox containers, and hardware firmware all in one go.

* **OS-Only Update:**
  ```bash
  sudo bootc upgrade
  ```
  Pulls the latest OS image layers in the background and stages them for the next boot.

* **TPM2 Hardware Disk Encryption:**
  ```bash
  ujust toggle-tpm2
  ```
  Binds your LUKS disk encryption to your laptop's TPM2 hardware security chip for passwordless boot.

---

## Releases & Versioning

* **`:latest`**: Continuously built from the `main` branch.
* **Semantic Versioning (`:v0.1.2`, `:v0.2.0`, etc.)**: Tagged releases published to [GitHub Releases](https://github.com/mgrusso/orca/releases) and mirrored on GitHub Container Registry (`ghcr.io/mgrusso/orca`).
