#!/usr/bin/env bash
set -euo pipefail

PROFILE_ROOT="/nix/var/nix/profiles/system"
THEMES=(default gruvbox sunset lain rey-light kitty light)

theme="${1:-}"

if [[ -z "$theme" ]]; then
  echo "usage: system-theme-switch <theme>" >&2
  echo "available themes: ${THEMES[*]}" >&2
  exit 2
fi

allowed=0
for t in "${THEMES[@]}"; do
  if [[ "$theme" == "$t" ]]; then
    allowed=1
    break
  fi
done

if [[ "$allowed" -ne 1 ]]; then
  echo "error: unknown theme '$theme'" >&2
  echo "available themes: ${THEMES[*]}" >&2
  exit 2
fi

if [[ "$theme" == "default" ]]; then
  switch="$PROFILE_ROOT/bin/switch-to-configuration"
else
  switch="$PROFILE_ROOT/specialisation/$theme/bin/switch-to-configuration"
fi

if [[ ! -x "$switch" ]]; then
  echo "error: theme '$theme' not found at $switch (run nh os switch first)" >&2
  exit 1
fi

exec "$switch" test
