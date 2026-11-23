{ lib, ... }:

{
  options.dendrite = {
    preferences = lib.mkOption {
      type = lib.types.submodule {
        options = {
          username = lib.mkOption {
            type = lib.types.str;
          };
          stateVersion = lib.mkOption {
            type = lib.types.str;
          };
          configDir = lib.mkOption {
            type = lib.types.str;
          };
          homeDirectory = lib.mkOption {
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
      };
    };

    earlyoom = lib.mkOption {
      type = lib.types.submodule {
        options = {
          memThreshold = lib.mkOption {
            type = lib.types.int;
            default = 12;
          };
          swapThreshold = lib.mkOption {
            type = lib.types.int;
            default = 10;
          };
        };
      };
      default = { };
    };

    nixos = lib.mkOption {
      type = lib.types.deferredModule;
      default = { };
    };

    home = lib.mkOption {
      type = lib.types.deferredModule;
      default = { };
    };
  };
}
