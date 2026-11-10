{ ... }:
{
  programs.zathura = {
    enable = true;

    options = {
      window-title-home-tilde = true;
      statusbar-home-tilde = true;
      scroll-step = 40;
      selection-clipboard = "clipboard";

      recolor = true;
      recolor-keephue = true;
      render-loading = true;
    };
  };
}
