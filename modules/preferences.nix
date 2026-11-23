{ ... }:

let
  username = "sazozm";
in
{
  config.dendrite.preferences = {
    inherit username;
    stateVersion = "26.05";
    configDir = "/home/${username}/.configs/nixos-merged";
    homeDirectory = "/home/${username}";
    hostName = "nixos";
    timeZone = "Europe/Minsk";
    nameServers = [
      "111.88.96.50"
      "111.88.96.51"
    ];
  };
}
