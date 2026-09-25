#!/usr/bin/env bash
set -eoux pipefail

echo "=== Building Orca Custom Layer ==="

# Enable COPR repositories if needed (e.g. noctalia or hyprland if not in main repos)
# Noctalia is present in Fedora 44+ repos or via copr
dnf copr enable -y lionheartp/Hyprland || true

# Packages to install:
# - Window managers: niri, hyprland (optional alternative)
# - Desktop Shell: noctalia (or noctalia-shell)
# - Power Management & Hardware: power-profiles-daemon, upower, brightnessctl, wireplumber, playerctl
# - Desktop Integration & File management: nautilus, gvfs, gvfs-smb, udisks2, polkit-gnome, xdg-desktop-portal-gnome, xdg-desktop-portal-gtk
# - Theming & Fonts: papirus-icon-theme, jetbrains-mono-fonts, google-inter-fonts, adw-gtk3-theme

dnf install -y \
    niri \
    hyprland \
    noctalia \
    brightnessctl \
    playerctl \
    nautilus \
    gvfs \
    gvfs-smb \
    gvfs-archive \
    udisks2 \
    polkit-gnome \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    jetbrains-mono-fonts \
    google-inter-fonts \
    papirus-icon-theme \
    adw-gtk3-theme || true

# Clean dnf caches to keep image size small
dnf clean all

# Ensure default services are enabled
systemctl enable power-profiles-daemon.service || true
systemctl enable udisks2.service || true

echo "=== Orca Custom Layer installed successfully ==="
