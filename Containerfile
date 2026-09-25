# Stage 1: Build & Package Collector (Fedora 44)
FROM fedora:44 AS builder

RUN dnf install -y \
    niri \
    hyprland \
    noctalia \
    brightnessctl \
    playerctl \
    polkit-gnome \
    papirus-icon-theme \
    adw-gtk3-theme \
    google-inter-fonts \
    jetbrains-mono-fonts

# Collect binaries, libraries, and desktop integration files
RUN mkdir -p /export/bin /export/libexec /export/lib64 /export/share /export/wayland-sessions && \
    # Binaries
    cp /usr/bin/niri /usr/bin/noctalia /usr/bin/hyprland /usr/bin/brightnessctl /usr/bin/playerctl /export/bin/ 2>/dev/null || true && \
    cp /usr/libexec/polkit-gnome-authentication-agent-1 /export/libexec/ 2>/dev/null || true && \
    # Wayland session files
    cp /usr/share/wayland-sessions/niri*.desktop /export/wayland-sessions/ 2>/dev/null || true && \
    cp /usr/share/wayland-sessions/hyprland*.desktop /export/wayland-sessions/ 2>/dev/null || true && \
    # Shared libraries for all collected binaries
    for bin in /export/bin/* /export/libexec/*; do \
        if [ -f "$bin" ]; then \
            ldd "$bin" 2>/dev/null | grep "=> /" | awk '{print $3}' | while read -r lib; do \
                cp -u "$lib" /export/lib64/ 2>/dev/null || true; \
            done; \
        fi \
    done && \
    # Themes and icons
    cp -r /usr/share/icons/Papirus* /export/share/ 2>/dev/null || true && \
    cp -r /usr/share/themes/adw-gtk3* /export/share/ 2>/dev/null || true


# Stage 2: Final Image (Dakota Native)
FROM ghcr.io/projectbluefin/dakota:stable

LABEL org.opencontainers.image.title="Orca" \
      org.opencontainers.image.description="Bluefin Dakota customized with Niri, Noctalia Shell and Ghostty" \
      org.opencontainers.image.vendor="mgrusso"

# Copy collected standalone binaries, libs, and assets from builder
COPY --from=builder /export/bin/ /usr/local/bin/
COPY --from=builder /export/libexec/ /usr/local/libexec/
COPY --from=builder /export/lib64/ /usr/local/lib64/orca/
COPY --from=builder /export/share/ /usr/local/share/
COPY --from=builder /export/wayland-sessions/ /usr/share/wayland-sessions/

# Copy dotfiles and configuration presets
COPY system_files/etc/skel/ /etc/skel/
COPY system_files/usr/ /usr/

# Configure library loader path
RUN echo "/usr/local/lib64/orca" > /etc/ld.so.conf.d/orca.conf && ldconfig
