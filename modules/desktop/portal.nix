{ config, ... }:

let
  module = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common.default = [
          "wlr"
          "gtk"
        ];
        wlroots.default = [
          "wlr"
          "gtk"
        ];
      };
    };
  };
in
{
  config.flake.nixosModules.portal = module;
  config.dendrite.nixos = module;
}
