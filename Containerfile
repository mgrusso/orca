FROM ghcr.io/ublue-os/bluefin:stable

LABEL org.opencontainers.image.title="Orca" \
      org.opencontainers.image.description="Bluefin customized with Niri, Noctalia Shell and Ghostty" \
      org.opencontainers.image.vendor="mgrusso"

# Enable COPR repositories for Hyprland and Ghostty
RUN (dnf5 -y copr enable lionheartp/Hyprland || dnf -y copr enable lionheartp/Hyprland || true) && \
    (dnf5 -y copr enable solopasha/hyprland || dnf -y copr enable solopasha/hyprland || true) && \
    (dnf5 -y copr enable scottames/ghostty || dnf -y copr enable scottames/ghostty || true)

# Install tiling window managers, terminal, desktop shell, utilities, wallpaper setter, and theming
# (Note: Nautilus, GNOME integration, PipeWire, Power Profiles, Bluefin Wallpapers and Homebrew are native in bluefin:stable)
RUN (rpm-ostree install \
        niri \
        hyprland \
        ghostty \
        noctalia \
        swaybg \
        brightnessctl \
        playerctl \
        wl-clipboard \
        mate-polkit \
        grim \
        slurp \
        swappy \
        wf-recorder \
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
        swaybg \
        brightnessctl \
        playerctl \
        wl-clipboard \
        mate-polkit \
        grim \
        slurp \
        swappy \
        wf-recorder \
        papirus-icon-theme \
        adw-gtk3-theme \
        rsms-inter-fonts \
        jetbrains-mono-fonts && \
     dnf5 clean all)

# Install Satty screenshot annotation tool from official GitHub release
RUN curl -sL https://github.com/Satty-org/Satty/releases/download/v0.22.0/satty-x86_64-unknown-linux-gnu.tar.gz | \
    tar -xz -C /tmp/ && \
    install -m 755 /tmp/satty /usr/bin/satty && \
    install -m 644 /tmp/satty.desktop /usr/share/applications/satty.desktop && \
    install -d /usr/share/icons/hicolor/scalable/apps && \
    install -m 644 /tmp/assets/satty.svg /usr/share/icons/hicolor/scalable/apps/satty.svg && \
    rm -rf /tmp/satty* /tmp/assets /tmp/man /tmp/completions

# Copy desktop integration, system configurations, and user skel dotfiles
COPY system_files/ /

# Ensure execution permissions for system helper scripts
RUN chmod +x /usr/libexec/orca-firstrun /usr/local/bin/*

# Compile gsettings schema overrides for system-wide dark mode & theming
RUN glib-compile-schemas /usr/share/glib-2.0/schemas/

# Brand the operating system as Orca in os-release for bootloader, hostnamectl, and fastfetch
RUN sed -i -e 's/^NAME=.*/NAME="Orca"/' \
           -e 's/^PRETTY_NAME=.*/PRETTY_NAME="Orca (Bluefin)"/' \
           /usr/lib/os-release

# Clean upstream Bluefin MOTD banners and neutralize umotd & user-motd
RUN rm -rf /etc/motd.d/* /etc/issue.d/* 2>/dev/null || true && \
    if [ -f /usr/bin/umotd ]; then printf '#!/bin/sh\nexit 0\n' > /usr/bin/umotd && chmod +x /usr/bin/umotd; fi && \
    if [ -f /usr/libexec/user-motd ]; then printf '#!/bin/sh\nexit 0\n' > /usr/libexec/user-motd && chmod +x /usr/libexec/user-motd; fi

# Configure Orca Plymouth boot splash theme
RUN cp -rn /usr/share/plymouth/themes/spinner/* /usr/share/plymouth/themes/orca/ 2>/dev/null || true && \
    plymouth-set-default-theme orca || true

# Make /etc/orca configuration directory writable so release channels can be managed without sudo
RUN mkdir -p /etc/orca && chmod 777 /etc/orca && ( [ -f /etc/orca/release-channel ] && chmod 666 /etc/orca/release-channel || true )


