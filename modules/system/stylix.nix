{ inputs, ... }:

{
  flake.nixosModules.stylix =
    { pkgs, lib, ... }:
    let
      mkTheme = name: image: polarity: scheme: extra: {
        ${name}.configuration.stylix = {
          image = lib.mkForce image;
          polarity = lib.mkForce polarity;
          base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
        }
        // extra;
      };
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

        image = ../../wallpapers/purpleWallpaper.png;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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
          size = 20;
        };

        opacity = {
          applications = 1.0;
          terminal = 0.9;
          desktop = 1.0;
          popups = 0.9;
        };
      };

      specialisation =
        mkTheme "gruvbox" ../../wallpapers/gruvbox-dark-rainbow.png "dark" "gruvbox-dark-medium" { }
        // mkTheme "sunset" ../../wallpapers/chillhop.com-cosy_retreat_sunset.png "dark" "rose-pine" { }
        // mkTheme "lain" ../../wallpapers/grey_lain_wallpaper.jpg "dark" "oxocarbon-dark" { }
        // mkTheme "rey-light" ../../wallpapers/rei.jpg "light" "blueforest" { }
        // mkTheme "kitty" ../../wallpapers/hello_kitty.jpg "light" "sakura" { }
        // mkTheme "light" ../../wallpapers/purpleWallpaper.png "light" "gruvbox-light-medium" {
          cursor = {
            package = lib.mkForce pkgs.bibata-cursors;
            name = lib.mkForce "Bibata-Modern-Classic";
            size = lib.mkForce 22;
          };
        };
    };
}
