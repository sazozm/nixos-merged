{ ... }:

{
  flake.nixosModules.displayManager = { pkgs, ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [ kdePackages.qtmultimedia ];
    };
  };
}
