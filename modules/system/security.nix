{ config, lib, ... }:

let
  themeNames = builtins.attrNames config.dendrite.themes;

  module =
    { config, pkgs, ... }:
    let
      themeSwitch = pkgs.writeShellScriptBin "system-theme-switch" (
        builtins.replaceStrings [ "@themes@" ] [ (lib.concatStringsSep " " themeNames) ] (
          builtins.readFile ../../scripts/system-theme-switch.sh
        )
      );
    in
    {
      environment.systemPackages = [ themeSwitch ];

      security.sudo.extraRules = [
        {
          users = [ config.preferences.username ];
          commands = [
            {
              command = "${themeSwitch}/bin/system-theme-switch";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
in
{
  config.flake.nixosModules.security = module;
  config.dendrite.nixos = module;
}
