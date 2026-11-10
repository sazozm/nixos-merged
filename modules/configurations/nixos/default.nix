{ self, inputs, ... }:

let
  baseModules = [
    ../../../hosts/nixos/hardware-configuration.nix
  ]
  ++ (with self.nixosModules; [
    preferences
    amd
    bluetooth
    input
    base
    locale
    boot
    network
    zram
    sysctl
    nix
    user
    stylix
    home
    portal
    mango
    audio
    displayManager
    gaming
    programs
    systemPackages
    fonts
    security
    ssh
    printing
    avahi
    murmur
    systemServices
    sops
  ]);

  mkSystem =
    extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        vimyt = self.packages.x86_64-linux.vimyt;
      };

      modules = baseModules ++ extraModules;
    };
in
{
  flake.nixosConfigurations = {
    nixos = mkSystem [ ];

    nixos-bootstrap = mkSystem [
      ({ lib, ... }: {
        specialisation = lib.mkForce { };
      })
    ];
  };
}
