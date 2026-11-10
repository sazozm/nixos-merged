{ ... }:

{
  flake.nixosModules.user = { config, pkgs, ... }: {
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
}
