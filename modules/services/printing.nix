{ ... }:

{
  flake.nixosModules.printing = { pkgs, ... }: {
    services.printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    services.system-config-printer.enable = true;
  };
}
