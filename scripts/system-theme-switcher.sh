#!/usr/bin/env bash
set -euo pipefail

WALLPAPERS="$HOME/.configs/nixos-merged/wallpapers"

THEMES="🟣 Purple|default|$WALLPAPERS/purpleWallpaper.png
🌾 Gruvbox Rainbow|gruvbox|$WALLPAPERS/gruvbox-dark-rainbow.png
🌇 Cosy Sunset|sunset|$WALLPAPERS/chillhop.com-cosy_retreat_sunset.png
🖤 Grey Lain|lain|$WALLPAPERS/grey_lain_wallpaper.jpg
☀️ Gruvbox Light|light|$WALLPAPERS/frieren_gruvbox.png
💠 Blue Light|rey-light|$WALLPAPERS/rei.jpg
🎀 Hello Kitty|kitty|$WALLPAPERS/hello_kitty.jpg"

CHOSEN=$(echo "$THEMES" | cut -d'|' -f1 | rofi -dmenu -i -p "󰸉 System Theme")
[ -z "$CHOSEN" ] && exit 0

LINE=$(echo "$THEMES" | grep -F -m1 "$CHOSEN|")
SPEC=$(echo "$LINE" | cut -d'|' -f2)
WALL=$(echo "$LINE" | cut -d'|' -f3)

if ! sudo system-theme-switch "$SPEC"; then
  notify-send -u critical "System Theme" "Activation reported errors. Check: systemctl status home-manager-$USER"
  exit 1
fi

noctalia msg config-reload >/dev/null 2>&1 || true
noctalia msg wallpaper-set "$WALL" >/dev/null 2>&1 || true
mmsg dispatch reload_config 2>/dev/null || true

notify-send -i "$WALL" "System Theme" "Switched to: $CHOSEN"
