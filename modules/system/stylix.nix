{ inputs, ... }:

{
  flake.nixosModules.stylix =
    { pkgs, lib, ... }:
    let
      schemes = {
        "catppuccin-mocha" = {
          name = "Catppuccin Mocha";
          palette = {
            base00 = "#1e1e2e";
            base01 = "#313244";
            base02 = "#45475a";
            base03 = "#6c7086";
            base04 = "#a6adc8";
            base05 = "#cdd6f4";
            base06 = "#f5e0dc";
            base07 = "#b4befe";
            base08 = "#f38ba8";
            base09 = "#fab387";
            base0A = "#f9e2af";
            base0B = "#a6e3a1";
            base0C = "#94e2d5";
            base0D = "#89b4fa";
            base0E = "#cba6f7";
            base0F = "#f2cdcd";
          };
        };
        "gruvbox-dark-medium" = {
          name = "Gruvbox dark, medium";
          palette = {
            base00 = "#282828";
            base01 = "#3c3836";
            base02 = "#504945";
            base03 = "#665c54";
            base04 = "#bdae93";
            base05 = "#d5c4a1";
            base06 = "#ebdbb2";
            base07 = "#fbf1c7";
            base08 = "#fb4934";
            base09 = "#fe8019";
            base0A = "#fabd2f";
            base0B = "#b8bb26";
            base0C = "#8ec07c";
            base0D = "#83a598";
            base0E = "#d3869b";
            base0F = "#d65d0e";
          };
        };
        "rose-pine" = {
          name = "Rosé Pine";
          palette = {
            base00 = "#191724";
            base01 = "#1f1d2e";
            base02 = "#26233a";
            base03 = "#6e6a86";
            base04 = "#908caa";
            base05 = "#e0def4";
            base06 = "#e0def4";
            base07 = "#524f67";
            base08 = "#eb6f92";
            base09 = "#f6c177";
            base0A = "#ebbcba";
            base0B = "#31748f";
            base0C = "#9ccfd8";
            base0D = "#c4a7e7";
            base0E = "#f6c177";
            base0F = "#524f67";
          };
        };
        "oxocarbon-dark" = {
          name = "Oxocarbon Dark";
          palette = {
            base00 = "#161616";
            base01 = "#262626";
            base02 = "#393939";
            base03 = "#525252";
            base04 = "#dde1e6";
            base05 = "#f2f4f8";
            base06 = "#ffffff";
            base07 = "#08bdba";
            base08 = "#ee5396";
            base09 = "#ff7eb6";
            base0A = "#ff6f00";
            base0B = "#42be65";
            base0C = "#3ddbd9";
            base0D = "#33b1ff";
            base0E = "#be95ff";
            base0F = "#82cfff";
          };
        };
        "blueforest" = {
          name = "Blue Forest";
          palette = {
            base00 = "#141F2E";
            base01 = "#1e5c1e";
            base02 = "#273e5c";
            base03 = "#a0ffa0";
            base04 = "#1e5c1e";
            base05 = "#FFCC33";
            base06 = "#91CCFF";
            base07 = "#375780";
            base08 = "#fffab1";
            base09 = "#FF8080";
            base0A = "#91CCFF";
            base0B = "#80ff80";
            base0C = "#80ff80";
            base0D = "#a2cff5";
            base0E = "#0099FF";
            base0F = "#e7e7e7";
          };
        };
        "sakura" = {
          name = "Sakura";
          palette = {
            base00 = "#feedf3";
            base01 = "#f8e2e7";
            base02 = "#e0ccd1";
            base03 = "#755f64";
            base04 = "#665055";
            base05 = "#564448";
            base06 = "#42383a";
            base07 = "#33292b";
            base08 = "#df2d52";
            base09 = "#f6661e";
            base0A = "#c29461";
            base0B = "#2e916d";
            base0C = "#1d8991";
            base0D = "#006e93";
            base0E = "#5e2180";
            base0F = "#ba0d35";
          };
        };
        "gruvbox-light-medium" = {
          name = "Gruvbox light, medium";
          palette = {
            base00 = "#fbf1c7";
            base01 = "#ebdbb2";
            base02 = "#d5c4a1";
            base03 = "#bdae93";
            base04 = "#665c54";
            base05 = "#504945";
            base06 = "#3c3836";
            base07 = "#282828";
            base08 = "#9d0006";
            base09 = "#af3a03";
            base0A = "#b57614";
            base0B = "#79740e";
            base0C = "#427b58";
            base0D = "#076678";
            base0E = "#8f3f71";
            base0F = "#d65d0e";
          };
        };
      };

      mkTheme = name: image: polarity: scheme: extra: {
        ${name}.configuration.stylix = {
          image = lib.mkForce image;
          polarity = lib.mkForce polarity;
          base16Scheme = lib.mkForce scheme;
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
        base16Scheme = schemes.catppuccin-mocha;

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
        mkTheme "gruvbox" ../../wallpapers/gruvbox-dark-rainbow.png "dark" schemes.gruvbox-dark-medium { }
        //
          mkTheme "sunset" ../../wallpapers/chillhop.com-cosy_retreat_sunset.png "dark" schemes.rose-pine
            { }
        // mkTheme "lain" ../../wallpapers/grey_lain_wallpaper.jpg "dark" schemes.oxocarbon-dark { }
        // mkTheme "rey-light" ../../wallpapers/rei.jpg "light" schemes.blueforest { }
        // mkTheme "kitty" ../../wallpapers/hello_kitty.jpg "light" schemes.sakura { }
        // mkTheme "light" ../../wallpapers/frieren_gruvbox.png "light" schemes.gruvbox-light-medium {
          cursor = {
            package = lib.mkForce pkgs.bibata-cursors;
            name = lib.mkForce "Bibata-Modern-Classic";
            size = lib.mkForce 22;
          };
        };
    };
}
