# Orca OS Custom Management Recipes
# Powering 'ujust orca-*' commands

# Configure the active Orca OS release channel (e.g. '0.2', '0.1' or 'latest')
orca-release-channel channel="":
    #!/usr/bin/env bash
    orca-release-channel "{{channel}}"

# Switch desktop color scheme synchronously between Catppuccin Mocha ('dark') and Latte ('light')
orca-theme theme="":
    #!/usr/bin/env bash
    orca-theme "{{theme}}"

# Launch the Orca OS interactive welcome tour and onboarding wizard
orca-welcome:
    #!/usr/bin/env bash
    orca-welcome &

# Lock the current desktop session via Noctalia (Super + Shift + L)
orca-lock:
    #!/usr/bin/env bash
    orca-lock



# Set wallpaper and synchronize Niri focus ring accent color
orca-wallpaper-sync target="random":
    #!/usr/bin/env bash
    orca-wallpaper-sync "{{target}}"

# Update the entire system: base OS image, Flatpaks, Homebrew and Distrobox containers
orca-update:
    #!/usr/bin/env bash
    orca-update

# Roll back to the previous OS deployment from before the last update
orca-rollback:
    #!/usr/bin/env bash
    orca-rollback

# Pin current deployment to permanently protect it from being pruned by future updates
orca-pin action="pin" index="0":
    #!/usr/bin/env bash
    orca-pin "{{action}}" "{{index}}"

# Reset desktop configurations (Niri, Noctalia, Ghostty, Hyprland, Fastfetch) to default settings
orca-clean:
    #!/usr/bin/env bash
    orca-clean

# Launch or create an instant Distrobox development container
orca-dev-box name="orca-dev" image="ghcr.io/ublue-os/fedora-toolbox:latest":
    #!/usr/bin/env bash
    orca-dev-box "{{name}}" "{{image}}"

# Restart PipeWire and WirePlumber audio services in case of sound or microphone issues
orca-fix-audio:
    #!/usr/bin/env bash
    echo "Restarting PipeWire and WirePlumber..."
    systemctl --user restart pipewire pipewire-pulse wireplumber
    echo "✨ Audio subsystem successfully restarted."

# Display Orca OS system and hardware information
orca-info:
    #!/usr/bin/env bash
    if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    else
        hostnamectl
    fi
