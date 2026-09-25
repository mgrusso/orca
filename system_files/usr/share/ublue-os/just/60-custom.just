# Orca OS Custom Management Recipes
# Powering 'ujust orca-*' commands

# Wechsle den Orca OS Release-Channel (z. B. '0.2', '0.1' oder 'latest')
orca-release-channel channel="":
    #!/usr/bin/env bash
    orca-release-channel "{{channel}}"

# Schalte das Farbschema synchron zwischen Catppuccin Mocha ('dark') und Latte ('light') um
orca-theme theme="":
    #!/usr/bin/env bash
    orca-theme "{{theme}}"

# Aktualisiere das gesamte System: OS-Image, Flatpaks, Homebrew und Distrobox-Container
orca-update:
    #!/usr/bin/env bash
    orca-update

# Setze Desktop-Konfigurationen (Niri, Noctalia, Ghostty, Hyprland) auf saubere Orca-Defaults zurück
orca-clean:
    #!/usr/bin/env bash
    orca-clean

# Erstelle oder starte einen schnellen Distrobox-Entwicklungscontainer
orca-dev-box name="orca-dev" image="ghcr.io/ublue-os/fedora-toolbox:latest":
    #!/usr/bin/env bash
    orca-dev-box "{{name}}" "{{image}}"

# Starte PipeWire- und WirePlumber-Audiodienste neu bei Ton- oder Mikrofonproblemen
orca-fix-audio:
    #!/usr/bin/env bash
    echo "Starte PipeWire und WirePlumber neu..."
    systemctl --user restart pipewire pipewire-pulse wireplumber
    echo "✨ Audio-Subsystem neu gestartet."

# Zeige Orca OS System- und Hardware-Informationen
orca-info:
    #!/usr/bin/env bash
    if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
    else
        hostnamectl
    fi
