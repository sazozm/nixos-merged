{ config, ... }:

let
  module = { pkgs, ... }: {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamemode.enable = true;
    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
      libstrangle
    ];
  };
in
{
  config.flake.nixosModules.gaming = module;
  config.dendrite.nixos = module;
}
