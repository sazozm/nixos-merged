{ ... }:

{
  flake.nixosModules.audio = {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      wireplumber.extraConfig = {
        "10-disable-autoswitch" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-profile" = false;
          };
        };
        "20-realtime-priority" = {
          "wireplumber.settings" = {
            "priority.realtime.audio" = 95;
            "priority.realtime.video" = 85;
            "priority.thread.audio" = 85;
          };
        };
      };
    };
  };
}
