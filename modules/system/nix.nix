{ inputs, ... }:

{
  flake.nixosModules.nix = { config, ... }: {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      http2 = false;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
      download-buffer-size = 524288000;
      max-jobs = "auto";
      connect-timeout = 5;
    };

    nix.registry.my.flake = inputs.self;

    nix.daemonCPUSchedPolicy = "idle";
    nix.daemonIOSchedPriority = 7;

    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "pnpm-10.29.2" ];
    };

    nixpkgs.overlays = [
      (final: prev: {
        mango = inputs.mango.packages.${final.stdenv.hostPlatform.system}.mango;
      })
    ];

    programs.nh = {
      enable = true;
      flake = "/home/${config.preferences.username}/.configs/nixos-merged";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 5";
      };
    };
  };
}
