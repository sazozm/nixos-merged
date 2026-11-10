{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10";
        "selection-target" = "clipboard";
      };
      scrollback = {
        lines = 10000;
        multiplier = 3;
      };
      mouse = {
        "hide-when-typing" = "yes";
      };
      cursor = {
        style = "beam";
        blink = "yes";
        "beam-thickness" = "0.5";
      };
      touch = {
        "long-press-delay" = 250;
      };

      "key-bindings" = {
        "clipboard-copy" = "Control+Shift+c XF86Copy";
        "clipboard-paste" = "Control+Shift+v XF86Paste";
      };
    };
  };
}
