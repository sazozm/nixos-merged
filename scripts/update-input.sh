#!/usr/bin/env bash
set -euo pipefail


FLAKE="${NH_FLAKE:-${FLAKE:-@flakeDir@}}"
keep=0
backup="$(mktemp)"

cleanup() {
  if [ "$keep" -eq 0 ]; then
    cp "$backup" "$FLAKE/flake.lock"
    printf 'restored flake.lock\n' >&2
  fi
  rm -f "$backup"
}
trap cleanup EXIT

usage() {
  printf 'usage: nix-update-input <input-name>\n' >&2
  exit 2
}

[ "$#" -eq 1 ] || usage
input="$1"

if [ ! -f "$FLAKE/flake.nix" ]; then
  printf 'error: flake not found at %s\n' "$FLAKE" >&2
  exit 2
fi

cp "$FLAKE/flake.lock" "$backup"

printf '==> updating input: %s\n' "$input"
update_log="$(mktemp)"
if ! nix --option abort-on-warn true flake update --flake "$FLAKE" "$input" 2>&1 | tee "$update_log"; then
  rm -f "$update_log"
  exit 1
fi
if grep -q "does not match any input" "$update_log"; then
  printf 'error: unknown input %s\n' "$input" >&2
  rm -f "$update_log"
  exit 2
fi
rm -f "$update_log"

printf '\n==> flake.lock diff\n'
git -C "$FLAKE" --no-pager diff -- flake.lock || true

printf '\n==> verifying configuration\n'
verify_script="$FLAKE/scripts/verify-config.sh"
if FLAKE="$FLAKE" bash "$verify_script"; then
  keep=1
  printf '\ninput %s updated and verified\n' "$input"
else
  printf '\nverification failed — rolling back flake.lock\n' >&2
  exit 1
fi
