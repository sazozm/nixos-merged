# NixOS + Home Manager configuration

Flake-based configuration for a single AMD desktop, built with `flake-parts`,
`import-tree` and Home Manager. Config lives in
`/home/sazozm/.configs/nixos-merged`.

## Structure

```
flake.nix                     flake inputs and import-tree entry point
hosts/nixos/                  hardware configuration for the host
modules/configurations/nixos/ nixosConfigurations (nixos, nixos-bootstrap)
modules/flake/                devShells, formatter, checks, packages, templates
modules/options.nix           dendrite options: preferences, themes, earlyoom, nixos, home
modules/preferences.nix       shared values (user, host, DNS, timezone)
modules/themes.nix            single source of truth for themes and palettes
modules/system/earlyoom.nix   earlyoom thresholds from dendrite.earlyoom
modules/features/             cross-class features (mango, ssh): NixOS + Home Manager
modules/system/               base system: boot, nix, users, security, services...
modules/desktop/              desktop: audio, display manager, gaming, portal
modules/hardware/             amd, bluetooth, input
modules/services/             networking, printing, avahi, murmur, sops
modules/home/                 Home Manager wiring
home/user/                    per-user programs (auto-imported via import-tree)
home/user/nixvim/             nixvim config split by feature (alpha, lsp, dap, keymaps...)
scripts/                      helper shell scripts exposed as packages
secrets/                      sops-encrypted secrets (age)
templates/                    project templates
wallpapers/                   theme wallpapers
```

Modules are auto-discovered under `modules/` via `import-tree` (dendritic
pattern). Every feature file contributes its NixOS module to the aggregated
`dendrite.nixos` deferred-module option declared in `modules/options.nix`,
and still exposes it as `flake.nixosModules.<name>` for compatibility.
`nixosConfigurations` import only `config.dendrite.nixos`, so adding a file
under `modules/` needs no import-list edit. Shared values live in
`dendrite.preferences` (`modules/preferences.nix`); Home Manager modules are
merged under `dendrite.home`. No `specialArgs`/`extraSpecialArgs` are used.

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

Fish shortcuts: `nix-reb`, `nix-test`, `nix-verify`, `nix-ui`, `nix-clean`
(abbreviations are in `home/user/fish.nix`).

Before switching, run `verify-config` — it checks the flake, dry-runs both
toplevels and validates key options. Update inputs one at a time with
`nix-update-input <name>` (fish: `nix-ui <name>`): it backs up `flake.lock`,
updates only that input, shows the diff and runs `verify-config`, restoring the
old lock automatically if verification fails. Avoid blanket `nix flake update`
— it previously pulled breaking changes (nixpkgs removing wayprompt, sonora
pulling `wgpu` via crane).

## Themes (specialisations)

Stylix themes are exposed as NixOS specialisations: `gruvbox`, `sunset`,
`lain`, `rey-light`, `kitty`, `light`, plus the default. They are declared
once in `modules/themes.nix`; the specialisations, the switcher allowlist and
the `check-themes`/`system-health` theme lists are generated from that option.
Switch at runtime with
the `system-theme-switcher` rofi menu. It calls the root-owned wrapper
`system-theme-switch <theme>`, which validates the name against a hardcoded
allowlist and runs `switch-to-configuration test`. Only that wrapper is allowed
passwordless in sudoers (no wildcards).

## Window manager (mango 0.18.6)

Config lives in `modules/features/mango.nix` (NixOS + Home Manager in one file).
All `spawn` binds use `bindn` (no key-repeat spam); media keys stay in `bindl`.
`SUPER+/` opens `wlr-which-key`, a global themed shortcut cheat sheet
(config in `modules/desktop/which-key.nix`).
`SUPER+CTRL,TAB` opens the draggable workspace overview
(`toggleworkspaceoverview,scroll_occupied`). `SUPER,TAB` is overcircle and
`SUPER+SHIFT,TAB` is focuslast. Updating the mango binary requires a session
restart, not just `SUPER+SHIFT+p`.

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
nix fmt -- --check       # check formatting without writing
nix build .#checks.x86_64-linux.formatting .#checks.x86_64-linux.shellcheck
```

`scripts/*.sh` must pass `shellcheck`; all `.nix` files must pass `nixfmt`.

`verify-config` (fish: `nix-verify`) runs `nix flake check`, dry-run builds of
both toplevels, and asserts key values (`preferences.username`,
`home.username`, hostname, theme specialisations, no `specialArgs`).
All its `nix` calls use `--option abort-on-warn true`, so an evaluation warning
fails the check. `nix flake check` only *evaluates* configurations — it does not
build them.

`nix-index-database` is enabled: `nix-locate <file>` finds the package that
provides a file, and `comma <command>` runs any command from nixpkgs without
installing it.

## Development shells and templates

```sh
nix develop .#cpp-gui     # C++ GUI (Raylib, SFML, SDL3, Qt6)
nix develop .#rust-gui    # Rust GUI
nix flake init -t .#cpp-qt6   # or rust-gui, cpp-raylib, cpp-sfml, cpp-sdl3
```

Fish functions scaffold a ready project (CMakeLists.txt, src/main.cpp, .envrc):
`create_cpp_project <name>` (plain C++), `create_raylib_project`,
`create_sfml_project`, `create_sdl_project`, `create_qt6_project`.

## Useful scripts

- `verify-config` — full pre-switch check (flake check + dry-run builds).
- `check-themes` — build bootstrap and every theme specialisation.
- `system-health` — verify zram swap, earlyoom thresholds (from
  `dendrite.earlyoom`) and theme specialisations.
- `mic-denoise` / `mic-normal` — switch the default mic to the passive DeepFilter
  noise-cancelling source and back. The source is created by PipeWire at boot
  and never becomes default on its own.
- `measure-eval` — measure peak evaluation memory of the system build.
