{ ... }:

{
  flake.nixosModules.murmur = {
    services.murmur = {
      enable = true;
      openFirewall = true;
      registerName = "PixelMic";
    };
  };
}
