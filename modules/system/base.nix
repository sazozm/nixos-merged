{ config, ... }:

let
  module = { config, ... }: {
    system.stateVersion = config.preferences.stateVersion;
  };
in
{
  config.flake.nixosModules.base = module;
  config.dendrite.nixos = module;
}
