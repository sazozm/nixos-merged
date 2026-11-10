{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors;
  opacity = config.stylix.opacity.popups;
in
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
      display-drun = "  Apps ";
      display-run = "  Run ";
      display-window = " 󰕰  Window ";
      sidebar-mode = true;
      font = "${config.stylix.fonts.monospace.name} ${toString config.stylix.fonts.sizes.popups}";
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
        rofiOpacity = toString (builtins.ceil (opacity * 100));
        mkRgba =
          color:
          mkLiteral "rgba ( ${colors."${color}-rgb-r"}, ${colors."${color}-rgb-g"}, ${colors."${color}-rgb-b"}, ${rofiOpacity}% )";
        mkRgb =
          color:
          mkLiteral "rgba ( ${colors."${color}-rgb-r"}, ${colors."${color}-rgb-g"}, ${colors."${color}-rgb-b"}, 100% )";
      in
      {
        "*" = {
          background = mkRgba "base00";
          lightbg = mkRgba "base01";
          red = mkRgba "base08";
          blue = mkRgba "base0D";
          lightfg = mkRgba "base06";
          foreground = mkRgba "base05";

          background-color = mkRgb "base00";
          separatorcolor = mkLiteral "@foreground";
          border-color = mkLiteral "@foreground";
          selected-normal-foreground = mkLiteral "@lightbg";
          selected-normal-background = mkLiteral "@lightfg";
          selected-active-foreground = mkLiteral "@background";
          selected-active-background = mkLiteral "@blue";
          selected-urgent-foreground = mkLiteral "@background";
          selected-urgent-background = mkLiteral "@red";
          normal-foreground = mkLiteral "@foreground";
          normal-background = mkLiteral "@background";
          active-foreground = mkLiteral "@blue";
          active-background = mkLiteral "@background";
          urgent-foreground = mkLiteral "@red";
          urgent-background = mkLiteral "@background";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-normal-background = mkLiteral "@lightbg";
          alternate-active-foreground = mkLiteral "@blue";
          alternate-active-background = mkLiteral "@lightbg";
          alternate-urgent-foreground = mkLiteral "@red";
          alternate-urgent-background = mkLiteral "@lightbg";

          base-text = mkRgb "base05";
          selected-normal-text = mkRgb "base01";
          selected-active-text = mkRgb "base00";
          selected-urgent-text = mkRgb "base00";
          normal-text = mkRgb "base05";
          active-text = mkRgb "base0D";
          urgent-text = mkRgb "base08";
          alternate-normal-text = mkRgb "base05";
          alternate-active-text = mkRgb "base0D";
          alternate-urgent-text = mkRgb "base08";

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
          background-color = mkLiteral "@background";
        };

        "message" = {
          border-color = mkLiteral "@separatorcolor";
        };

        "textbox" = {
          text-color = mkLiteral "@base-text";
        };

        "listview" = {
          padding = mkLiteral "4px 0";
          lines = 8;
          columns = 1;
          fixed-height = false;
          border-color = mkLiteral "@separatorcolor";
        };

        "element" = {
          padding = mkLiteral "9px 10px";
          spacing = mkLiteral "8px";
          border-radius = mkLiteral "8px";
        };

        "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };

        "element-icon" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          size = mkLiteral "0.8em";
        };

        "element normal.normal" = {
          background-color = mkLiteral "@normal-background";
          text-color = mkLiteral "@normal-text";
        };

        "element normal.urgent" = {
          background-color = mkLiteral "@urgent-background";
          text-color = mkLiteral "@urgent-text";
        };

        "element normal.active" = {
          background-color = mkLiteral "@active-background";
          text-color = mkLiteral "@active-text";
        };

        "element selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-text";
        };

        "element selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-text";
        };

        "element selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-text";
        };

        "element alternate.normal" = {
          background-color = mkLiteral "@alternate-normal-background";
          text-color = mkLiteral "@alternate-normal-text";
        };

        "element alternate.urgent" = {
          background-color = mkLiteral "@alternate-urgent-background";
          text-color = mkLiteral "@alternate-urgent-text";
        };

        "element alternate.active" = {
          background-color = mkLiteral "@alternate-active-background";
          text-color = mkLiteral "@alternate-active-text";
        };

        "scrollbar" = {
          width = mkLiteral "4px";
          handle-width = mkLiteral "4px";
          handle-color = mkLiteral "@normal-foreground";
        };

        "sidebar" = {
          border-color = mkLiteral "@separatorcolor";
        };

        "button" = {
          text-color = mkLiteral "@normal-text";
        };

        "button selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-text";
        };

        "inputbar" = {
          spacing = mkLiteral "8px";
          padding = mkLiteral "10px 12px";
          border-radius = mkLiteral "10px";
          text-color = mkLiteral "@normal-text";
        };

        "case-indicator" = {
          text-color = mkLiteral "@normal-text";
        };

        "entry" = {
          text-color = mkLiteral "@normal-text";
        };

        "prompt" = {
          text-color = mkLiteral "@normal-text";
        };

        "textbox-prompt-colon" = {
          text-color = mkLiteral "inherit";
        };

        "prompt, entry, element-icon, element-text" = {
          vertical-align = mkLiteral "0.5";
        };
      };
  };
}
