{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 8;
      indicator-caps-lock = true;
      show-failed-attempts = true;
      fade-in = 0.2;
      effect-blur = "8x4";
      effect-vignette = "0.5:0.5";

      ring-color = c.base02;
      ring-clear-color = c.base0D;
      ring-caps-lock-color = c.base0E;
      ring-ver-color = c.base0D;
      ring-wrong-color = c.base08;

      inside-color = c.base00;
      inside-clear-color = c.base00;
      inside-caps-lock-color = c.base00;
      inside-ver-color = c.base00;
      inside-wrong-color = c.base00;

      line-color = c.base00;
      line-clear-color = c.base00;
      line-caps-lock-color = c.base00;
      line-ver-color = c.base00;
      line-wrong-color = c.base00;

      text-color = c.base05;
      text-clear-color = c.base05;
      text-caps-lock-color = c.base0E;
      text-ver-color = c.base0D;
      text-wrong-color = c.base08;

      key-hl-color = c.base0B;
      bs-hl-color = c.base08;
      caps-lock-key-hl-color = c.base0E;
      separator-color = "00000000";
    };
  };
}
