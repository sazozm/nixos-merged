{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    settings = {
      modi = "run,drun,window";
      show-icons = true;
      icon-theme = "Oranchelo";
      terminal = "foot";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window ";
      sidebar-mode = true;
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "*" = {
          margin = mkLiteral "0";
          padding = mkLiteral "0";
          spacing = mkLiteral "0";
          border-radius = mkLiteral "10px";
        };

        "window" = {
          location = mkLiteral "center";
          width = mkLiteral "480";
          border = mkLiteral "2px";
          border-radius = mkLiteral "14px";
          padding = mkLiteral "6px";
        };

        "inputbar" = {
          spacing = mkLiteral "8px";
          padding = mkLiteral "10px 12px";
          border-radius = mkLiteral "10px";
        };

        "prompt, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };

        "listview" = {
          padding = mkLiteral "4px 0";
          lines = 8;
          columns = 1;
          fixed-height = false;
        };

        "element" = {
          padding = mkLiteral "9px 10px";
          spacing = mkLiteral "8px";
          border-radius = mkLiteral "8px";
        };

        "element-icon" = {
          size = mkLiteral "0.8em";
        };

        "scrollbar" = {
          width = mkLiteral "4px";
          handle-width = mkLiteral "4px";
        };
      };
  };
}
