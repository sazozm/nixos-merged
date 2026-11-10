{ ... }:

{
  flake.nixosModules.portal = { pkgs, ... }: {
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
}
