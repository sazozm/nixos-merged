{ config, inputs, ... }:

let
  themes = config.dendrite.themes;
  defaultTheme = themes.default;

  module =
    { pkgs, lib, ... }:
    let
      mkSpecialisation = name: theme: {
        ${name}.configuration.stylix = {
          image = lib.mkForce theme.wallpaper;
          polarity = lib.mkForce theme.polarity;
          base16Scheme = lib.mkForce theme.scheme;
          cursor = {
            package = lib.mkForce pkgs.bibata-cursors;
            name = lib.mkForce "Bibata-Modern-Classic";
            size = lib.mkForce theme.cursorSize;
          };
        };
      };

      themeNames = builtins.filter (name: name != "default") (builtins.attrNames themes);
    in
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = {
        enable = true;
        autoEnable = true;

        targets = {
          nixvim.enable = true;
          chromium.enable = true;
        };

        image = defaultTheme.wallpaper;
        polarity = defaultTheme.polarity;
        base16Scheme = defaultTheme.scheme;

        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };
          sansSerif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Sans";
          };
          serif = {
            package = pkgs.dejavu_fonts;
            name = "DejaVu Serif";
          };
          sizes = {
            applications = 11;
            terminal = 15;
            desktop = 11;
            popups = 10;
          };
        };

        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = defaultTheme.cursorSize;
        };

        opacity = {
          applications = 1.0;
          terminal = 0.9;
          desktop = 1.0;
          popups = 0.9;
        };
      };

      specialisation = lib.foldl' (acc: name: acc // mkSpecialisation name themes.${name}) { } themeNames;
    };
in
{
  config.flake.nixosModules.stylix = module;
  config.dendrite.nixos = module;
}
