{ ... }:

{
  flake.nixosModules.preferences = { lib, ... }: {
    options.preferences = {
      username = lib.mkOption {
        type = lib.types.str;
      };
      stateVersion = lib.mkOption {
        type = lib.types.str;
      };
    };

    config.preferences = {
      username = "sazozm";
      stateVersion = "26.05";
    };
  };
}
