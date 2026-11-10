# NixOS + Home Manager configuration

Flake-based configuration for a single AMD desktop, built with `flake-parts`,
`import-tree` and Home Manager. User: `sazozm`. Config lives in
`/home/sazozm/.configs/nixos-merged`.

## Structure

```
flake.nix                     flake inputs and import-tree entry point
hosts/nixos/                  hardware configuration for the host
modules/configurations/nixos/ nixosConfigurations (nixos, nixos-bootstrap)
modules/flake/                devShells, formatter, checks, packages, templates
modules/system/               base system: boot, nix, users, security, services...
modules/desktop/              desktop: mango, audio, display manager, gaming, portal
modules/hardware/             amd, bluetooth, input
modules/services/             networking, ssh, printing, avahi, murmur, sops
modules/home/                 Home Manager wiring
home/user/                    per-user programs and dotfiles
scripts/                      helper shell scripts exposed as packages
secrets/                      sops-encrypted secrets (age)
templates/                    project templates
wallpapers/                   theme wallpapers
```

Modules are auto-discovered under `modules/` via `import-tree`; every file
exposes a `flake.nixosModules.<name>` or `flake.perSystem` output.

## Configurations

- `nixos` — main system with all specialisations.
- `nixos-bootstrap` — same system without specialisations, used as a fallback
  and for the theme build smoke test.

Build and activate:

```sh
nh os switch ~/.configs/nixos-merged   # build + switch
nh os test  ~/.configs/nixos-merged   # temporary activation
nh os boot  ~/.configs/nixos-merged   # set next boot
# or
sudo nixos-rebuild switch --flake ~/.configs/nixos-merged#nixos
```

Fish shortcuts: `nix-update`, `nix-reb`, `nix-test`.

## Themes (specialisations)

Stylix themes are exposed as NixOS specialisations: `gruvbox`, `sunset`,
`lain`, `rey-light`, `kitty`, `light`, plus the default. Switch at runtime with
the `system-theme-switcher` rofi menu. It calls the root-owned wrapper
`system-theme-switch <theme>`, which validates the name against a hardcoded
allowlist and runs `switch-to-configuration test`. Only that wrapper is allowed
passwordless in sudoers (no wildcards).

## Secrets (sops-nix)

Age recipients are declared in `.sops.yaml`. The private key is expected at
`~/.config/sops/age/keys.txt`; the host SSH key is used as a second key.

```sh
sops secrets/services.yaml        # edit
sops -d secrets/services.yaml     # decrypt for inspection
```

Secrets are declared in `modules/services/sops.nix` and exposed under
`/run/secrets/`. The default sops file is `secrets/services.yaml`; each secret
should set `sopsFile` explicitly when it lives elsewhere.

## Checks and formatting

```sh
nix flake check          # formatting + shellcheck checks
nix fmt                  # format all .nix files with nixfmt
nix build .#checks.x86_64-linux.formatting .#checks.x86_64-linux.shellcheck
```

`scripts/*.sh` must pass `shellcheck`; all `.nix` files must pass `nixfmt`.

## Development shells and templates

```sh
nix develop .#cpp-gui     # C++ GUI (Raylib, SFML, SDL3, Qt6)
nix develop .#rust-gui    # Rust GUI
nix flake init -t .#cpp-qt6   # or rust-gui, cpp-raylib, cpp-sfml, cpp-sdl3
```

## Useful scripts

- `check-themes` — build bootstrap and every theme specialisation.
- `system-health` — verify zram swap, earlyoom and theme specialisations.
- `measure-eval` — measure peak evaluation memory of the system build.
