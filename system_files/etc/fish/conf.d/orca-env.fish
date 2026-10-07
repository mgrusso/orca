# Orca OS - Fish Shell Environment Integration (Silent & Non-intrusive)

# 1. User Local Bin
if test -d $HOME/.local/bin
    if not contains $HOME/.local/bin $PATH
        set -gx PATH $HOME/.local/bin $PATH
    end
end

# 2. Homebrew Environment Integration
if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test -d /home/linuxbrew/.linuxbrew/bin
    if not contains /home/linuxbrew/.linuxbrew/bin $PATH
        set -gx PATH /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin $PATH
    end
end

# 3. Flatpak Binaries Integration
if test -d $HOME/.local/share/flatpak/exports/bin
    if not contains $HOME/.local/share/flatpak/exports/bin $PATH
        set -gx PATH $PATH $HOME/.local/share/flatpak/exports/bin
    end
end
if test -d /var/lib/flatpak/exports/bin
    if not contains /var/lib/flatpak/exports/bin $PATH
        set -gx PATH $PATH /var/lib/flatpak/exports/bin
    end
end

# 4. GNOME Keyring SSH agent socket
if not set -q SSH_AUTH_SOCK; and set -q XDG_RUNTIME_DIR
    if test -S $XDG_RUNTIME_DIR/keyring/ssh
        set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/keyring/ssh
    end
end

# 5. Interactive Terminal Welcome Banner (Fastfetch)
if status is-interactive
    if not set -q ORCA_FETCH_SHOWN; and command -v fastfetch >/dev/null 2>&1
        set -gx ORCA_FETCH_SHOWN 1
        fastfetch
    end

    # 6. Starship Prompt Integration
    if command -v starship >/dev/null 2>&1
        starship init fish | source
    end
end
