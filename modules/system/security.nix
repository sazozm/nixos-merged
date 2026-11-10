{ ... }:

{
  flake.nixosModules.security = { config, ... }: {
    security.sudo.extraRules = [
      {
        users = [ config.preferences.username ];
        commands = [
          {
            command = "/nix/var/nix/profiles/system/specialisation/*/bin/switch-to-configuration";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/nix/var/nix/profiles/system/bin/switch-to-configuration";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
