{ ... }:

{
  flake.nixosModules.security =
    { config, pkgs, ... }:
    let
      themeSwitch = pkgs.writeShellScriptBin "system-theme-switch" (
        builtins.readFile ../../scripts/system-theme-switch.sh
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
}
