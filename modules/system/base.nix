{ ... }:

{
  flake.nixosModules.base = { config, ... }: {
    system.stateVersion = config.preferences.stateVersion;
  };
}
