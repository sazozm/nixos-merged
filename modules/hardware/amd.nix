{ ... }:

{
  flake.nixosModules.amd = { pkgs, ... }: {
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ obs-studio-plugins.obs-vkcapture ];
      extraPackages32 = with pkgs; [ obs-studio-plugins.obs-vkcapture ];
    };
  };
}
