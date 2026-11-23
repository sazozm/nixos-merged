{ config, ... }:

let
  module = {
    services.libinput.enable = true;
  };
in
{
  config.flake.nixosModules.input = module;
  config.dendrite.nixos = module;
}
