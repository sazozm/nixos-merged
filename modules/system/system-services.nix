{ ... }:

{
  flake.nixosModules.systemServices = {
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.upower.enable = true;
    services.fstrim.enable = true;
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 5;
    };
    services.power-profiles-daemon.enable = true;

    security.polkit.enable = true;
    programs.dconf.enable = true;

    boot.supportedFilesystems = [
      "ntfs"
      "exfat"
    ];

    programs.kdeconnect.enable = true;
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };

    systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
    services.journald.settings.Journal.SystemMaxUse = "500M";
  };
}
