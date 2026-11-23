{ config, ... }:

let
  module = { pkgs, ... }: {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;

      extraConfig.pipewire."99-input-denoising" = {
        "context.modules" = [
          {
            "name" = "libpipewire-module-filter-chain";
            "args" = {
              "node.description" = "DeepFilter Noise Cancelling Source";
              "media.name" = "DeepFilter Noise Cancelling Source";
              "filter.graph" = {
                "nodes" = [
                  {
                    "type" = "ladspa";
                    "name" = "DeepFilter Mono";
                    "plugin" = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                    "label" = "deep_filter_mono";
                  }
                ];
              };
              "audio.rate" = 48000;
              "capture.props" = {
                "node.name" = "deep_filter_mono_input";
                "node.passive" = true;
              };
              "playback.props" = {
                "node.name" = "deep_filter_mono_output";
                "media.class" = "Audio/Source";
              };
            };
          }
        ];
      };
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
in
{
  config.flake.nixosModules.audio = module;
  config.dendrite.nixos = module;
}
