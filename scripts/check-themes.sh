#!/usr/bin/env bash
set -euo pipefail

FLAKE="${NH_FLAKE:-${FLAKE:-$HOME/.configs/nixos-merged}}"
BASE_CONFIG="${BASE_CONFIG:-nixos-bootstrap}"
CONFIG="${CONFIG:-nixos}"
MAX_JOBS="${MAX_JOBS:-2}"
CORES="${CORES:-4}"

THEMES=(
  gruvbox
  sunset
  lain
  rey-light
  kitty
  light
)

if [ ! -f "$FLAKE/flake.nix" ]; then
  printf 'error: flake not found at %s\n' "$FLAKE" >&2
  exit 1
fi

build() {
  local attr="$1"
  printf '\n==> %s\n' "$attr"
  nix build "${FLAKE}#${attr}" --no-link --max-jobs "$MAX_JOBS" --cores "$CORES"
}

build "nixosConfigurations.${BASE_CONFIG}.config.system.build.toplevel"

for theme in "${THEMES[@]}"; do
  build "nixosConfigurations.${CONFIG}.config.specialisation.\"${theme}\".configuration.system.build.toplevel"
done

if [ "${FULL:-0}" = "1" ]; then
  build "nixosConfigurations.${CONFIG}.config.system.build.toplevel"
fi

printf '\nAll configurations built successfully.\n'
