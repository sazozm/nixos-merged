{
  config,
  lib,
  inputs,
  ...
}:

let
  prefs = config.dendrite.preferences;
  earlyoom = config.dendrite.earlyoom;
  themes = config.dendrite.themes;
  themeNames = builtins.attrNames themes;

  themeEntries = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
      name: theme: "  \"${theme.emoji} ${theme.label}|${name}|${theme.polarity}|${theme.wallpaper}\""
    ) themes
  );

  nixosModule = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.${prefs.username} = {
        imports = [
          config.dendrite.home
          inputs.nixvim.homeModules.nixvim
          inputs.mango.hmModules.mango
          inputs.noctalia.homeModules.default
        ];
      };
    };
  };

  homeModule = { pkgs, lib, ... }: {
    imports = [
      ../../home/default.nix
      (inputs.import-tree ../../home/user)
    ];

    home.username = prefs.username;
    home.homeDirectory = prefs.homeDirectory;
    home.stateVersion = prefs.stateVersion;

    programs.nixvim.nixpkgs.source = inputs.nixpkgs;

    home.packages = [
      (pkgs.writeShellScriptBin "system-theme-switcher" (
        builtins.replaceStrings [ "@themeEntries@" ] [ themeEntries ] (
          builtins.readFile ../../scripts/system-theme-switcher.sh
        )
      ))
      (pkgs.writeShellScriptBin "check-themes" (
        builtins.replaceStrings
          [ "@themes@" "@flakeDir@" ]
          [
            (lib.concatStringsSep " " themeNames)
            prefs.configDir
          ]
          (builtins.readFile ../../scripts/check-themes.sh)
      ))
      (pkgs.writeShellScriptBin "system-health" (
        builtins.replaceStrings
          [ "@themes@" "@eoMem@" "@eoSwap@" ]
          [
            (lib.concatStringsSep " " themeNames)
            (toString earlyoom.memThreshold)
            (toString earlyoom.swapThreshold)
          ]
          (builtins.readFile ../../scripts/system-health.sh)
      ))
      (pkgs.writeShellScriptBin "verify-config" (
        builtins.replaceStrings [ "@flakeDir@" ] [ prefs.configDir ] (
          builtins.readFile ../../scripts/verify-config.sh
        )
      ))
      (pkgs.writeShellScriptBin "nix-update-input" (
        builtins.replaceStrings [ "@flakeDir@" ] [ prefs.configDir ] (
          builtins.readFile ../../scripts/update-input.sh
        )
      ))
      (pkgs.writeShellScriptBin "mic-denoise" ''
        #!/usr/bin/env bash
        set -euo pipefail
        state="''${XDG_RUNTIME_DIR:-/tmp}/mic-denoise-prev"
        target="deep_filter_mono_output"
        if ! pactl list short sources | grep -q "$target"; then
          echo "DeepFilter source is not available yet — restart PipeWire or relogin" >&2
          exit 1
        fi
        current="$(pactl get-default-source)"
        [ "$current" = "$target" ] && { echo "DeepFilter mic already active"; exit 0; }
        printf '%s\n' "$current" > "$state"
        pactl set-default-source "$target"
        notify-send -a Mic "DeepFilter microphone enabled" 2>/dev/null || true
      '')
      (pkgs.writeShellScriptBin "mic-normal" ''
        #!/usr/bin/env bash
        set -euo pipefail
        state="''${XDG_RUNTIME_DIR:-/tmp}/mic-denoise-prev"
        if [ -r "$state" ]; then
          previous="$(cat "$state")"
          rm -f "$state"
        else
          previous="$(pactl list short sources | grep -v deep_filter_mono_output | head -n 1 | cut -f2)"
        fi
        if [ -n "$previous" ]; then
          pactl set-default-source "$previous"
          notify-send -a Mic "Default microphone restored" 2>/dev/null || true
        fi
      '')
    ];
  };
in
{
  config.flake.nixosModules.home = nixosModule;
  config.dendrite.nixos = nixosModule;
  config.dendrite.home = homeModule;
}
