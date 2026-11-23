{ config, ... }:

let
  nixos = { ... }: {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };

  home = { ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          User = "git";
          IdentityFile = "/run/secrets/git_ssh_key";
          IdentitiesOnly = true;
        };
      };
    };
  };
in
{
  config.flake.nixosModules.ssh = nixos;
  config.dendrite.nixos = nixos;
  config.dendrite.home = home;
}
