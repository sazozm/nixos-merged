{ inputs, ... }:

{
  flake.nixosModules.home =
    { config, ... }:
    let
      username = config.preferences.username;
      stateVersion = config.preferences.stateVersion;
      homeDirectory = "/home/${username}";
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit
              inputs
              username
              stateVersion
              homeDirectory
              ;
          };
          home-manager.users.${username} = {
            imports = [
              ../../home/default.nix
              inputs.nixvim.homeModules.nixvim
              inputs.mango.hmModules.mango
              inputs.sonora.homeManagerModules.default
              inputs.noctalia.homeModules.default
            ];
          };
        }
      ];
    };
}
