{ config, ... }:

let
  eo = config.dendrite.earlyoom;

  module = { ... }: {
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = eo.memThreshold;
      freeSwapThreshold = eo.swapThreshold;
    };
  };
in
{
  config.flake.nixosModules.earlyoom = module;
  config.dendrite.nixos = module;
}
