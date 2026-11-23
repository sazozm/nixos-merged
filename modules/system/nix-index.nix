{ inputs, ... }:

let
  module = { ... }: {
    imports = [ inputs.nix-index-database.nixosModules.default ];

    programs.nix-index-database.comma.enable = true;
  };
in
{
  config.flake.nixosModules.nixIndex = module;
  config.dendrite.nixos = module;
}
