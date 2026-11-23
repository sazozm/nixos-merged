{ config, inputs, ... }:

let
  homeDirectory = config.dendrite.preferences.homeDirectory;

  module = { config, pkgs, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = ../../secrets/services.yaml;
      validateSopsFiles = true;

      age = {
        keyFile = "${homeDirectory}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        demo = {
          sopsFile = ../../secrets/demo.yaml;
          key = "demo";
          owner = config.preferences.username;
        };

        "git_ssh_key" = {
          sopsFile = ../../secrets/git.yaml;
          key = "ssh_key";
          owner = config.preferences.username;
          mode = "0400";
        };

        "openrouter_api_key" = {
          sopsFile = ../../secrets/services.yaml;
          key = "openrouter_api_key";
          owner = config.preferences.username;
          mode = "0400";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];
  };
in
{
  config.flake.nixosModules.sops = module;
  config.dendrite.nixos = module;
}
