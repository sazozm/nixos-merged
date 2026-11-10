{ ... }:

{
  flake.nixosModules.network = { lib, ... }: {
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
      hostName = "nixos";
      useDHCP = lib.mkDefault true;

      nameservers = [
        "111.88.96.50"
        "111.88.96.51"
      ];

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
}
