#!/usr/bin/env bash
set -euo pipefail

FLAKE="${NH_FLAKE:-${FLAKE:-@flakeDir@}}"
fail=0

ok() { printf 'ok: %s\n' "$*"; }
bad() { printf 'FAIL: %s\n' "$*"; fail=1; }

if [ ! -f "$FLAKE/flake.nix" ]; then
  printf 'error: flake not found at %s\n' "$FLAKE" >&2
  exit 2
fi

printf '\n==> nix flake check\n'
if nix --option abort-on-warn true flake check "$FLAKE"; then
  ok "flake check"
else
  bad "flake check"
fi

for cfg in nixos nixos-bootstrap; do
  printf '\n==> dry-run %s\n' "$cfg"
  built=0
  for _ in 1 2; do
    if nix --option abort-on-warn true build "$FLAKE#nixosConfigurations.$cfg.config.system.build.toplevel" \
      --no-link --dry-run >/dev/null 2>&1; then
      built=1
      break
    fi
  done
  if [ "$built" -eq 1 ]; then
    ok "$cfg toplevel"
  else
    bad "$cfg toplevel"
  fi
done

expect() {
  local attr="$1" expected="$2" actual
  actual="$(nix --option abort-on-warn true eval --raw "$FLAKE#$attr" 2>/dev/null || true)"
  if [ "$actual" = "$expected" ]; then
    ok "$attr = $expected"
  else
    bad "$attr = ${actual:-?} (expected $expected)"
  fi
}

printf '\n==> key values\n'
username="$(nix --option abort-on-warn true eval --raw "$FLAKE#nixosConfigurations.nixos.config.preferences.username" 2>/dev/null || true)"
hostname="$(nix --option abort-on-warn true eval --raw "$FLAKE#nixosConfigurations.nixos.config.preferences.hostName" 2>/dev/null || true)"
expect "nixosConfigurations.nixos.config.home-manager.users.$username.home.username" "$username"
expect nixosConfigurations.nixos.config.networking.hostName "$hostname"

themes="$(
  nix --option abort-on-warn true eval "$FLAKE#nixosConfigurations.nixos.config.specialisation" \
    --apply 'x: builtins.length (builtins.attrNames x)' 2>/dev/null || true
)"
if [[ "$themes" =~ ^[0-9]+$ ]] && [ "$themes" -gt 0 ]; then
  ok "theme specialisations = $themes"
else
  bad "theme specialisations = ${themes:-?} (expected a positive number)"
fi

printf '\n==> dendritic invariants\n'
if grep -R -n -E 'specialArgs|extraSpecialArgs' "$FLAKE/modules" "$FLAKE/home" \
  --include='*.nix' 2>/dev/null; then
  bad "specialArgs pass-thru found"
else
  ok "no specialArgs pass-thru"
fi

printf '\n'
if [ "$fail" -eq 0 ]; then
  printf 'all checks passed\n'
else
  printf 'some checks failed\n'
fi
exit "$fail"
