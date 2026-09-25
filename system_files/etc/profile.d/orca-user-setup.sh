#!/bin/sh
# Orca OS - User Environment Setup (Silent & Non-intrusive)

# 1. User Local Bin
if [ -d "$HOME/.local/bin" ]; then
    case ":$PATH:" in
        *:"$HOME/.local/bin":*) ;;
        *) export PATH="$HOME/.local/bin:$PATH" ;;
    esac
fi

# 2. Homebrew Environment Integration
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null)"
elif [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
    case ":$PATH:" in
        *:/home/linuxbrew/.linuxbrew/bin:*) ;;
        *) export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH" ;;
    esac
fi

# 3. Flatpak Binaries Integration
if [ -d "$HOME/.local/share/flatpak/exports/bin" ]; then
    case ":$PATH:" in
        *:"$HOME/.local/share/flatpak/exports/bin":*) ;;
        *) export PATH="$PATH:$HOME/.local/share/flatpak/exports/bin" ;;
    esac
fi
if [ -d "/var/lib/flatpak/exports/bin" ]; then
    case ":$PATH:" in
        *:/var/lib/flatpak/exports/bin:*) ;;
        *) export PATH="$PATH:/var/lib/flatpak/exports/bin" ;;
    esac
fi

# 4. Fallback: Seed Ghostty configuration if missing
GHOSTTY_CONF="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
if [ -n "$HOME" ] && [ ! -f "$GHOSTTY_CONF" ]; then
    mkdir -p "$(dirname "$GHOSTTY_CONF")" 2>/dev/null || true
    if [ -f "/etc/skel/.config/ghostty/config" ]; then
        cp "/etc/skel/.config/ghostty/config" "$GHOSTTY_CONF" 2>/dev/null || true
    fi
fi
