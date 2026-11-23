{ config, ... }:

let
  module = {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.upower.enable = true;
    services.fstrim.enable = true;
    services.power-profiles-daemon.enable = true;

    security.polkit.enable = true;
    programs.dconf.enable = true;

    boot.supportedFilesystems = [
      "ntfs"
      "exfat"
    ];

  };
in
{
  config.flake.nixosModules.systemServices = module;
  config.dendrite.nixos = module;
}
