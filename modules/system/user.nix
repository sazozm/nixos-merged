{ config, ... }:

let
  module = { config, pkgs, ... }: {
    users.users.${config.preferences.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "input"
        "networkmanager"
        "render"
        "realtime"
        "adbusers"
        "lp"
        "scanner"
      ];
      shell = pkgs.fish;
    };
  };
in
{
  config.flake.nixosModules.user = module;
  config.dendrite.nixos = module;
}
