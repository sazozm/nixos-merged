{ ... }:

{
  flake.nixosModules.programs = {
    programs.fish.enable = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    programs.nix-ld.enable = true;

    services.flatpak.enable = true;
  };
}
