#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  FLAKE="${NH_FLAKE:-${FLAKE:-$HOME/.configs/nixos-merged}}"
  set -- nix build "${FLAKE}#nixosConfigurations.nixos.config.system.build.toplevel" --no-link
fi

systemd-run --user --scope -p MemoryAccounting=yes -- bash -c '
  set -euo pipefail
  cgroup="/sys/fs/cgroup$(cut -d: -f3 /proc/self/cgroup)"
  set +e
  "$@"
  status=$?
  set -e
  peak="$(cat "$cgroup/memory.peak")"
  printf "peak eval memory: %d MiB\n" "$((peak / 1024 / 1024))"
  exit "$status"
' bash "$@"
