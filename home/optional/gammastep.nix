{ pkgs, ... }:
{
  services.gammastep = {
    enable = true;
    provider = "manual";

    latitude = 52.09;
    longitude = 23.69;

    temperature = {
      day = 5700;
      night = 3500;
    };

    settings = {
      general = {
        fade-time = 1;
        gamma = 0.9;
      };
    };
  };
}
