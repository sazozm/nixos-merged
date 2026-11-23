{ ... }:

let
  module = { ... }: {
    systemd.settings.Manager.DefaultTimeoutStopSec = "10s";
    services.journald.settings.Journal.SystemMaxUse = "500M";
  };
in
{
  config.flake.nixosModules.journald = module;
  config.dendrite.nixos = module;
}
