{ inputs, ... }:

{
  flake.nixosModules.sops = { config, pkgs, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = ../../secrets/demo.yaml;
      validateSopsFiles = true;

      age = {
        keyFile = "/home/${config.preferences.username}/.config/sops/age/keys.txt";
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        demo = {
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
}
