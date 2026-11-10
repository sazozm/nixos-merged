{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.92;
      background-blur = true;

      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      window-theme = "ghostty";

      unfocused-split-opacity = 0.9;
      mouse-hide-while-typing = true;

      cursor-style = "bar";
      cursor-style-blink = true;
    };
  };
}
