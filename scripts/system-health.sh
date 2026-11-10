#!/usr/bin/env bash
set -u

fail=0

ok() { printf 'ok: %s\n' "$*"; }
bad() { printf 'FAIL: %s\n' "$*"; fail=1; }

if grep -q '^/dev/zram0[[:space:]]' /proc/swaps; then
  ok "zram swap active"
else
  bad "zram swap not active"
fi

eo_pid="$(systemctl show -p MainPID --value earlyoom 2>/dev/null || true)"
if [ -n "$eo_pid" ] && [ "$eo_pid" != "0" ]; then
  eo_args="$(tr '\0' ' ' < "/proc/$eo_pid/cmdline" 2>/dev/null || true)"
  if [[ "$eo_args" == *"-m5"* && "$eo_args" == *"-s5"* ]]; then
    ok "earlyoom thresholds (-m5 -s5)"
  else
    bad "earlyoom thresholds: ${eo_args:-unknown}"
  fi
else
  bad "earlyoom not running"
fi

themes=(gruvbox sunset lain rey-light kitty light)
for theme in "${themes[@]}"; do
  if [ -x "/run/current-system/specialisation/$theme/bin/switch-to-configuration" ]; then
    ok "theme $theme"
  else
    bad "theme $theme missing (run nh os switch)"
  fi
done

printf '\nsystem: %s\n' "$(readlink -f /run/current-system)"
printf 'swap:\n'
cat /proc/swaps

if command -v zramctl >/dev/null 2>&1; then
  printf 'zram:\n'
  zramctl
fi

exit "$fail"
