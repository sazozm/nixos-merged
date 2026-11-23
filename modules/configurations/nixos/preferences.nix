{ config, ... }:

let
  prefs = config.dendrite.preferences;

  module = { lib, ... }: {
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
      hostName = lib.mkOption {
        type = lib.types.str;
      };
      timeZone = lib.mkOption {
        type = lib.types.str;
      };
      nameServers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
      };
    };

    config.preferences = {
      inherit (prefs)
        username
        stateVersion
        configDir
        hostName
        timeZone
        nameServers
        ;
    };
  };
in
{
  config.flake.nixosModules.preferences = module;
  config.dendrite.nixos = module;
}
