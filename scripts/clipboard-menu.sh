#!/usr/bin/env bash
set -euo pipefail

selected=$(cliphist list | rofi -dmenu -i -p "󰅍 Clipboard" -theme-str 'window {width: 500px;} listview {lines: 10;}')

[ -n "$selected" ] && printf '%s\n' "$selected" | cliphist decode | wl-copy
