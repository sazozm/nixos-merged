{ ... }:

{
  flake.nixosModules.nvidia = { config, pkgs, ... }: {
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      powerManagement.enable = true;
      nvidiaSettings = false;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    environment.systemPackages = with pkgs; [ nvitop ];
  };
}
