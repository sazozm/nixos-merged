{ config, ... }:

let
  module = {
    programs.fish.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    programs.nix-ld.enable = true;

    services.flatpak.enable = true;
  };
in
{
  config.flake.nixosModules.programs = module;
  config.dendrite.nixos = module;
}
