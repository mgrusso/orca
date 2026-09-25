FROM ghcr.io/ublue-os/bluefin:stable

LABEL org.opencontainers.image.title="Orca" \
      org.opencontainers.image.description="Bluefin customized with Niri, Noctalia Shell and Ghostty" \
      org.opencontainers.image.vendor="mgrusso"

# Enable COPR repositories for Hyprland and Ghostty
RUN (dnf5 -y copr enable lionheartp/Hyprland || dnf -y copr enable lionheartp/Hyprland || true) && \
    (dnf5 -y copr enable solopasha/hyprland || dnf -y copr enable solopasha/hyprland || true) && \
    (dnf5 -y copr enable scottames/ghostty || dnf -y copr enable scottames/ghostty || true)

# Install tiling window managers, terminal, desktop shell, utilities, and theming
# (Note: Nautilus, GNOME integration, PipeWire, Power Profiles and Homebrew are native in bluefin:stable)
RUN (rpm-ostree install \
        niri \
        hyprland \
        ghostty \
        noctalia \
        brightnessctl \
        playerctl \
        wl-clipboard \
        mate-polkit \
        papirus-icon-theme \
        adw-gtk3-theme \
        rsms-inter-fonts \
        jetbrains-mono-fonts && \
     rpm-ostree cleanup -m) || \
    (dnf5 install -y \
        niri \
        hyprland \
        ghostty \
        noctalia \
        brightnessctl \
        playerctl \
        wl-clipboard \
        mate-polkit \
        papirus-icon-theme \
        adw-gtk3-theme \
        rsms-inter-fonts \
        jetbrains-mono-fonts && \
     dnf5 clean all)

# Copy desktop integration, system configurations, and user skel dotfiles
COPY system_files/ /

# Compile gsettings schema overrides for system-wide dark mode & theming
RUN glib-compile-schemas /usr/share/glib-2.0/schemas/
