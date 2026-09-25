#!/bin/sh
# Ensure Ghostty config is populated from /etc/skel if missing
# Ghostty generates a default config if ~/.config/ghostty/config is missing.
GHOSTTY_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
if [ -n "$HOME" ] && [ ! -f "$GHOSTTY_CONF" ]; then
    mkdir -p "$(dirname "$GHOSTTY_CONF")"
    if [ -f "/etc/skel/.config/ghostty/config" ]; then
        cp "/etc/skel/.config/ghostty/config" "$GHOSTTY_CONF"
    fi
fi
