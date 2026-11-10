{ ... }:

let
  username = "sazozm";
in
{
  flake.nixosModules.preferences = { lib, ... }: {
    options.preferences = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      stateVersion = lib.mkOption {
        type = lib.types.str;
      };
      configDir = lib.mkOption {
        type = lib.types.str;
      };
    };

    config.preferences = {
      inherit username;
      stateVersion = "26.05";
      configDir = "/home/${username}/.configs/nixos-merged";
    };
  };
}
