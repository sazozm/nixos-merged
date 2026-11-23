{ config, inputs, ... }:

let
  mkSystem =
    extraModules:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ../../../hosts/nixos/hardware-configuration.nix
        config.dendrite.nixos
      ]
      ++ extraModules;
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
