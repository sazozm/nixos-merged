{ config, pkgs, ... }:

let
  vaultPath = "Notes";
in
{
  home.packages = [ pkgs.obsidian ];

  home.activation = {
    createObsidianVault = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/${vaultPath}"
    '';
  };

  home.file = {
    "${vaultPath}/.obsidian/appearance.json".text = builtins.toJSON {
      accentColor = "cba6f7";
      theme = "obsidian";
      cssTheme = "Catppuccin";
    };

    "${vaultPath}/.obsidian/themes/Catppuccin/theme.css".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/obsidian/main/theme.css";
      hash = "sha256-8p0jsRHbk/+G+MYV+TFurIhL1JzXm+ijtNlZm2wwQuQ=";
    };
  };
}
