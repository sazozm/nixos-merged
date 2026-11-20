#!/usr/bin/env bash
set -euo pipefail

WALLPAPERS="$HOME/.configs/nixos-merged/wallpapers"

PALETTE="stylix"

THEMES=(
  "🟣 Purple|default|dark|$WALLPAPERS/purpleWallpaper.png"
  "🌾 Gruvbox Rainbow|gruvbox|dark|$WALLPAPERS/gruvbox-dark-rainbow.png"
  "🌇 Cosy Sunset|sunset|dark|$WALLPAPERS/chillhop.com-cosy_retreat_sunset.png"
  "🖤 Grey Lain|lain|dark|$WALLPAPERS/grey_lain_wallpaper.jpg"
  "☀️ Gruvbox Light|light|light|$WALLPAPERS/frieren_gruvbox.png"
  "💠 Blue Light|rey-light|light|$WALLPAPERS/rei.jpg"
  "🎀 Hello Kitty|kitty|light|$WALLPAPERS/hello_kitty.jpg"
)

usage() {
  echo "usage: system-theme-switcher [--list | --apply 'spec|mode|wallpaper']" >&2
  exit 2
}

list_themes() {
  local entry
  for entry in "${THEMES[@]}"; do
    printf '%s\t%s\n' "${entry%%|*}" "${entry#*|}"
  done
}

apply_theme() {
  local selection="$1" data spec mode wall switch_bin

  data="${selection#*$'\t'}"
  if [[ "$data" == "$selection" ]]; then
    data="$selection"
  fi
  IFS='|' read -r spec mode wall <<< "$data"

  if [[ -z "$spec" || -z "$mode" || -z "$wall" ]]; then
    echo "error: invalid theme selection: $selection" >&2
    return 2
  fi

  switch_bin="$(readlink -f "$(command -v system-theme-switch || true)")"
  if [[ -z "$switch_bin" || ! -x "$switch_bin" ]]; then
    notify-send -u critical "System Theme" "system-theme-switch not found. Run nh os switch first."
    return 1
  fi

  if ! sudo "$switch_bin" "$spec"; then
    notify-send -u critical "System Theme" "Activation failed. See the theme switch output for details."
    return 1
  fi

  if ! noctalia msg color-scheme-get >/dev/null 2>&1; then
    notify-send -u critical "System Theme" "Noctalia is not running, the theme was switched but the shell keeps its colours."
    return 1
  fi

  noctalia msg color-scheme-set custom "$PALETTE" >/dev/null 2>&1 || true
  noctalia msg theme-mode-set "$mode" >/dev/null 2>&1 || true
  noctalia msg wallpaper-set "$wall" >/dev/null 2>&1 || true
  noctalia msg config-reload >/dev/null 2>&1 || true
  noctalia msg templates-apply >/dev/null 2>&1 || true
  mmsg dispatch reload_config 2>/dev/null || true

  if ! noctalia msg color-scheme-get 2>/dev/null | grep -q "^custom $PALETTE$"; then
    notify-send -u critical "System Theme" "Noctalia still uses the palette '$(noctalia msg color-scheme-get 2>/dev/null)'."
    return 1
  fi

  notify-send -i "$wall" "System Theme" "Switched to: $spec"
}

case "${1:-}" in
  --list)
    shift
    [[ $# -eq 0 ]] || usage
    list_themes
    ;;
  --apply)
    shift
    [[ $# -eq 1 ]] || usage
    apply_theme "$1"
    ;;
  "")
    chosen=$(printf '%s\n' "${THEMES[@]}" | cut -d'|' -f1 | rofi -dmenu -i -p "󰸉 System Theme")
    [[ -z "$chosen" ]] && exit 0
    entry=$(printf '%s\n' "${THEMES[@]}" | grep -F -m1 "$chosen|")
    apply_theme "${entry#*|}"
    ;;
  *)
    usage
    ;;
esac
