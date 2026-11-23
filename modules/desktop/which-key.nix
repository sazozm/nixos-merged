{ ... }:

let
  home = { config, pkgs, ... }: {
    xdg.configFile."wlr-which-key/config.yaml" = {
      source = (pkgs.formats.yaml { }).generate "config.yaml" {
        font = "JetBrainsMono Nerd Font 12";
        background = "${config.lib.stylix.colors.withHashtag.base00}d0";
        color = config.lib.stylix.colors.withHashtag.base05;
        border = config.lib.stylix.colors.withHashtag.base0E;
        separator = " ➜ ";
        border_width = 2;
        corner_r = 10;
        padding = 15;
        rows_per_column = 5;
        column_padding = 25;
        anchor = "bottom-right";
        margin_right = 0;
        margin_bottom = 5;
        margin_left = 5;
        margin_top = 0;
        auto_kbd_layout = true;
        inhibit_compositor_keyboard_shortcuts = true;

        menu = [
          {
            key = "w";
            desc = "Window";
            submenu = [
              {
                key = "f";
                desc = "Focus last";
                cmd = "mmsg dispatch focuslast";
              }
              {
                key = "v";
                desc = "Toggle floating";
                cmd = "mmsg dispatch togglefloating";
              }
              {
                key = "m";
                desc = "Maximize screen";
                cmd = "mmsg dispatch togglemaximizescreen";
              }
              {
                key = "q";
                desc = "Kill client";
                cmd = "mmsg dispatch killclient";
              }
              {
                key = "t";
                desc = "Tile layout";
                cmd = "mmsg dispatch setlayout tile";
              }
              {
                key = "s";
                desc = "Scroller layout";
                cmd = "mmsg dispatch setlayout scroller";
              }
            ];
          }
          {
            key = "a";
            desc = "Apps";
            submenu = [
              {
                key = "t";
                desc = "Terminal";
                cmd = "kitty";
              }
              {
                key = "f";
                desc = "Firefox";
                cmd = "firefox";
              }
              {
                key = "o";
                desc = "Obsidian";
                cmd = "obsidian";
              }
              {
                key = "c";
                desc = "Clipboard";
                cmd = "noctalia msg panel-toggle clipboard";
              }
            ];
          }
          {
            key = "s";
            desc = "Screenshot";
            submenu = [
              {
                key = "f";
                desc = "Fullscreen";
                cmd = "noctalia msg screenshot-fullscreen";
              }
              {
                key = "r";
                desc = "Region";
                cmd = "noctalia msg screenshot-region";
              }
              {
                key = "a";
                desc = "Annotate";
                cmd = "noctalia msg screenshot-annotate";
              }
            ];
          }
          {
            key = "t";
            desc = "Theme";
            submenu = [
              {
                key = "t";
                desc = "Switch theme";
                cmd = "system-theme-switcher";
              }
              {
                key = "w";
                desc = "Wallpaper";
                cmd = "noctalia msg panel-toggle wallpaper";
              }
            ];
          }
          {
            key = "m";
            desc = "Media";
            submenu = [
              {
                key = "p";
                desc = "Play / pause";
                cmd = "noctalia msg media toggle";
              }
              {
                key = "n";
                desc = "Next";
                cmd = "noctalia msg media next";
              }
              {
                key = "b";
                desc = "Previous";
                cmd = "noctalia msg media previous";
              }
            ];
          }
          {
            key = "p";
            desc = "Power / session";
            submenu = [
              {
                key = "l";
                desc = "Lock";
                cmd = "noctalia msg session lock";
              }
              {
                key = "s";
                desc = "Session panel";
                cmd = "noctalia msg panel-toggle session";
              }
              {
                key = "c";
                desc = "Control center";
                cmd = "noctalia msg panel-toggle control-center";
              }
            ];
          }
        ];
      };
    };

    home.packages = [ pkgs.wlr-which-key ];
  };
in
{
  config.dendrite.home = home;
}
