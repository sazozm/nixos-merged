{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      rounded_corners = true;
      proc_gradient = true;
      truecolor = true;
      update_ms = 1000;
    };
  };
}
