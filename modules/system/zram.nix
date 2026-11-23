{ config, ... }:

let
  module = {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };
  };
in
{
  config.flake.nixosModules.zram = module;
  config.dendrite.nixos = module;
}
