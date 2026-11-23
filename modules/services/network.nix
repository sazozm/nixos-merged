{ config, ... }:

let
  module = { config, lib, ... }: {
    services.resolved = {
      enable = true;
      settings = {
        Resolve = {
          Cache = "yes";
          DNSStubListener = "yes";
          LLMNR = "false";
          MulticastDNS = "false";
          DNSSEC = "allow-downgrade";
        };
      };
    };

    networking = {
      hostName = config.preferences.hostName;
      useDHCP = lib.mkDefault true;

      nameservers = config.preferences.nameServers;

      networkmanager = {
        enable = true;
        connectionConfig."connection.wake-on-lan" = 1;
        wifi.powersave = false;
      };

      firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
      };
    };
  };
in
{
  config.flake.nixosModules.network = module;
  config.dendrite.nixos = module;
}
