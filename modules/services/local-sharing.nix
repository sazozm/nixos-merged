{ ... }:

let
  module = { ... }: {
    programs.kdeconnect.enable = true;
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
in
{
  config.flake.nixosModules.localSharing = module;
  config.dendrite.nixos = module;
}
