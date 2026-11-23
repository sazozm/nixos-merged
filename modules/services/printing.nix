{ config, ... }:

let
  module = { pkgs, ... }: {
    services.printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    services.system-config-printer.enable = true;
  };
in
{
  config.flake.nixosModules.printing = module;
  config.dendrite.nixos = module;
}
