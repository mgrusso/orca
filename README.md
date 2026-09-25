# Orca OS 🐋

A modern, immutable, scroll-tiling operating system built on **Project Bluefin (Fedora Atomic)**. Orca comes preconfigured with the **Niri** scroll-tiling window manager, **Noctalia Shell**, the **Ghostty** terminal, a native Libadwaita onboarding tour, dynamic wallpaper accent synchronization, and a unified **Catppuccin** aesthetic.

---

## 🌟 Highlights

* 🌊 **Atomic & Immutable Core:** Backed by Fedora Silverblue / Bluefin container images with transactional OSTree deployments and instant rollback capabilities.
* 📜 **Niri Scroll-Tiling (Default):** Infinite horizontal window strip with 1:1 trackpad gestures and smooth animations.
* 🪟 **Alternative Sessions:** Seamless Hyprland session available from the GDM display manager.
* 🐚 **Noctalia Shell:** Polished status bar, application launcher, notifications center, and quick settings panel.
* 🎨 **Unified Catppuccin Theming:** System-wide Catppuccin Mocha (dark) and Latte (light) integration across Ghostty, GTK4/Libadwaita, Noctalia, and Plymouth.
* 🖼️ **Dynamic Wallpaper & Accent Synchronization:** On-the-fly wallpaper shuffling (`Super + Shift + W`) with automatic dominant-color extraction that syncs the Niri active focus ring live.
* 🧭 **Native Libadwaita Onboarding Wizard (`orca-welcome`):** A 5-step onboarding tour covering appearance, browser selection (Firefox, Brave, Vivaldi), essential shortcuts, and autostart control.
* 🔒 **Hardware-Bound Disk Encryption:** Passwordless LUKS unlocking via laptop TPM2 security chip (`ujust toggle-tpm2`).
* 📦 **Universal Packaging:** Native Flatpak integration with Flathub, Homebrew (`/home/linuxbrew/.linuxbrew`), and Distrobox developer containers.
* 🛡️ **Fail-Safe Bootloader & Rollback:** 5-second visible GRUB countdown with instant rollback selection in case of broken deployments.
* ⚡ **100% Passwordless System Updates:** Polkit-authorized transactional updates for the OS, Flatpaks, Brew, and containers via `ujust orca-update`.

---

## 🚀 Installation

### Option A: Bare-Metal Installation via Bootable USB / ISO (Recommended)

Orca provides automated bootable installer ISOs built directly from container images via GitHub Actions:

1. Head over to the [GitHub Actions](https://github.com/mgrusso/orca/actions/workflows/build-iso.yml) tab and select **Build Orca ISO Installer**.
2. Click **Run workflow** (select target image tag, e.g. `v0.2` or `latest`).
3. Download the generated ISO artifact from the workflow run (or grab it from [GitHub Releases](https://github.com/mgrusso/orca/releases)).
4. Flash the ISO to a USB drive using **Fedora Media Writer**, **Raspberry Pi Imager**, **Rufus**, **Ventoy**, or `dd`:
   ```bash
   sudo dd if=orca-v0.2-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync
   ```
5. Boot from the USB drive and follow the standard Fedora Anaconda installer to install Orca OS to your drive.

---

### Option B: Rebase from Existing Fedora Silverblue / Bluefin

If you already run a bootc- or rpm-ostree-based system (Fedora Silverblue, Kinoite, Aurora, or Bluefin), you can switch to Orca with a single command:

```bash
# Rebase to Orca OS (Stable 0.2 Channel)
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mgrusso/orca:v0.2

# Reboot into Orca OS
sudo systemctl reboot
```

After rebooting, select **Orca (Niri)** from the gear session menu on the GDM login screen.

---

## 🛠️ Orca Management Commands (`ujust`)

Orca ships with dedicated CLI commands for hassle-free maintenance:

```text
🐋 Welcome to Orca OS!
──────────────────────────────────────────────────────────
• ujust orca-welcome         - Launch onboarding wizard & tour
• ujust orca-update          - Update OS, Flatpaks, Brew & containers (passwordless)
• ujust orca-rollback        - Roll back to previous OS release
• ujust orca-pin             - Pin/protect deployment from updates
• ujust orca-theme           - Switch between Catppuccin Mocha & Latte
• ujust orca-wallpaper-sync  - Sync wallpaper & Niri focus ring color
• ujust orca-release-channel - Switch release channel (0.2, 0.1, latest)
• ujust orca-clean           - Reset desktop settings to factory defaults
• ujust orca-dev-box         - Launch isolated Distrobox dev container
• Super + Space              - Noctalia Application Launcher
• Super + ?                  - Show keyboard shortcuts cheatsheet
• orca-info / fastfetch      - System status & hardware details
──────────────────────────────────────────────────────────
```

---

## 🌿 Release Channels & Versioning

Orca uses release channels to balance rock-solid stability with rapid feature development:

| Channel | Image Tag | Purpose |
| :--- | :--- | :--- |
| **`0.2`** (Default) | `ghcr.io/mgrusso/orca:v0.2` | Current stable release branch. Receives tested point releases. |
| **`0.1`** | `ghcr.io/mgrusso/orca:v0.1` | Previous stable maintenance line. |
| **`latest`** | `ghcr.io/mgrusso/orca:latest` | Bleeding edge development built automatically on every push to `main`. |

To inspect or switch your release channel:
```bash
# View active channel and list available options
ujust orca-release-channel

# Switch to the bleeding edge channel
ujust orca-release-channel latest

# Apply changes and pull updates for the selected channel
ujust orca-update
```

---

## ⌨️ Essential Keyboard Shortcuts (Niri)

| Shortcut | Action |
| :--- | :--- |
| `Super + Space` or `Super + D` | **Noctalia Application Launcher** |
| `Super + Return` or `Super + T` | **Ghostty Terminal** |
| `Super + C` / `Super + N` | **Noctalia Control Center & Notifications** |
| `Super + Shift + W` | **Shuffle Wallpaper & Harmonize Niri Accent Ring** |
| `Super + Left / Right` | **Scroll across tiling columns** (or trackpad gesture) |
| `Super + 1 ... 9` | **Switch to workspace 1 through 9** |
| `Super + Shift + 1 ... 9` | **Move active column/window to workspace 1 through 9** |
| `Super + Q` | **Close focused window** |
| `Super + F` | **Maximize window / column** |
| `Super + Shift + F` | **Fullscreen window** |
| `Super + R` | **Cycle column width presets (33% / 50% / 66%)** |
| `Print` or `Super + Shift + S` | **Take screenshot with Satty annotation editor** |
| `Super + Shift + R` | **Toggle screen recording (wf-recorder)** |
| `Super + ?` | **Interactive keyboard shortcuts cheatsheet overlay** |

---

## 🛡️ Rollback & Recovery

Every time `ujust orca-update` runs, the previous system deployment is automatically preserved by OSTree:

1. **Bootloader Fallback:** The GRUB menu is displayed for 5 seconds on every boot (`menu_auto_hide=0`). If an update fails to boot, simply select the second boot entry (*"Orca rollback"*) to boot into the previous working deployment.
2. **Instant In-Session Rollback:**
   ```bash
   ujust orca-rollback
   sudo systemctl reboot
   ```
3. **Deployment Pinning:**
   ```bash
   # Pin the currently booted deployment so future updates will never delete it
   ujust orca-pin pin 0
   ```

---

## 📄 License

Based on Project Bluefin (Apache 2.0). Orca OS additions and configurations are open-source under the Apache 2.0 License.
