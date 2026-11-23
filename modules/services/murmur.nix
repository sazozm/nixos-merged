{ config, ... }:

let
  module = {
    services.murmur = {
      enable = true;
      openFirewall = true;
      registerName = "PixelMic";
    };
  };
in
{
  config.flake.nixosModules.murmur = module;
  config.dendrite.nixos = module;
}
