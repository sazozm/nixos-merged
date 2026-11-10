{ ... }:

{
  flake.nixosModules.boot = { pkgs, ... }: {
    boot = {
      tmp.cleanOnBoot = false;

      loader = {
        systemd-boot.enable = false;
        efi = {
          canTouchEfiVariables = false;
          efiSysMountPoint = "/boot";
        };
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          configurationLimit = 10;
          forceInstall = true;
          efiInstallAsRemovable = true;
        };
        timeout = 5;
      };

      kernelPackages = pkgs.linuxPackages_zen;
      kernelParams = [ "amd_pstate=active" ];
    };
  };
}
