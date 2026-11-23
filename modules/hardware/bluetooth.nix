{ config, ... }:

let
  module = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
in
{
  config.flake.nixosModules.bluetooth = module;
  config.dendrite.nixos = module;
}
