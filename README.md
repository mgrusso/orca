# Orca 🐋

Ein angepasstes, unveränderliches (atomic/bootc) Betriebssystem-Image basierend auf **Project Bluefin**, vorkonfiguriert mit einem modernen Tiling Window Manager (**Niri** & **Hyprland**), der **Noctalia Shell**, dem **Ghostty** Terminal und durchgängigem Dark-Theming.

---

## Highlights

* 🌊 **Bluefin Core:** Behält alle Vorzüge von Bluefin (Homebrew, Flatpak, `ujust`, Hardware-Beschleunigung, automatische Updates).
* 🪟 **Tiling Window Managers:**
  * **Niri (Standard):** Flüssiges, stufenloses Scroll-Tiling – perfekt für Notebook-Trackpads mit 1:1-Wischgesten.
  * **Hyprland:** Dynamisches Tiling mit modernen Animationen als alternative Session beim Login wählbar.
* 🐚 **Noctalia Shell:** Integriertes Control Center, Launcher, Statusbar und Benachrichtigungen.
* ⚡ **Notebook Power Management:** Voll integrierter `power-profiles-daemon` & UPower (Umschaltung direkt im Noctalia Quick-Settings-Panel).
* 📁 **GNOME Komfort:** Nautilus (Dateien), automatische Einbindung externer Speichermedien (`gvfs`/`udisks2`), Polkit-GNOME Dialoge.
* 🎨 **Durchgängiges Theming:** Abgestimmtes *Catppuccin Mocha / Deep Ocean* Farbschema in Ghostty, Noctalia Shell, Niri und GTK/Adwaita.

---

## Tastenkürzel (Niri & Hyprland)

| Taste | Aktion |
|---|---|
| `Super + Return` | Ghostty Terminal öffnen |
| `Super + D` | Noctalia App-Launcher umschalten |
| `Super + C` | Noctalia Control Center (WLAN, Helligkeit, Power-Profile) |
| `Super + E` | Nautilus Dateimanager |
| `Super + Q` | Fenster schließen |
| `Super + F` | Fenster / Spalte vergrößern |
| `Super + 1..5` | Zu Arbeitsbereich 1 bis 5 wechseln |
| `Fn / Medientasten` | Lautstärke, Helligkeit und Medienwiedergabe steuern |

---

## Installation / Rebase auf dem Notebook

Führe auf deinem System (z. B. Bluefin / Fedora Atomic) folgende Befehle im Terminal aus:

```bash
# 1. Aktuellen Status prüfen
rpm-ostree status

# 2. Auf Orca rebasen
rpm-ostree rebase ostree-unverified-registry:ghcr.io/mgrusso/orca:latest

# 3. Notebook neu starten
systemctl reboot
```

> **Hinweis zur Sicherheit:** OSTree speichert deine vorherige Bluefin-Installation im Boot-Menü. Du kannst beim Booten jederzeit die vorherige Version auswählen und zurückrollen (`rpm-ostree rollback`).
