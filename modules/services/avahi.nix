{ config, ... }:

let
  module = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
in
{
  config.flake.nixosModules.avahi = module;
  config.dendrite.nixos = module;
}
