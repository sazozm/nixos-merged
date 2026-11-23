{ config, ... }:

let
  module = { config, ... }: {
    time.timeZone = config.preferences.timeZone;

    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ru_RU.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_TIME = "ru_RU.UTF-8";
        LC_MEASUREMENT = "ru_RU.UTF-8";
        LC_PAPER = "ru_RU.UTF-8";
        LC_MONETARY = "ru_RU.UTF-8";
      };
    };
  };
in
{
  config.flake.nixosModules.locale = module;
  config.dendrite.nixos = module;
}
