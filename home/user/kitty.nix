{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      disable_ligatures = "cursor";

      window_padding_width = 10;
      dynamic_background_opacity = "yes";
      confirm_os_window_close = 0;

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_edge = "top";
      tab_bar_min_tabs = 2;
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      tab_title_template = "{index}: {title}";

      window_border_width = "1px";
      draw_minimal_borders = "yes";

      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.35";
      cursor_trail_start_threshold = 2;

      scrollback_pager = "${pkgs.neovim}/bin/nvim -u NONE -c 'set nonumber nolist showtabline=0 foldcolumn=0' -c 'autocmd TermOpen * normal G' -c 'silent write! /tmp/kitty_scrollback' -c 'terminal cat /tmp/kitty_scrollback - '";
      scrollback_lines = 10000;

      allow_remote_control = "yes";
      listen_on = "unix:@kitty";

      url_style = "curly";
      open_url_with = "default";
      detect_urls = "yes";

      repaint_delay = 8;
      input_delay = 1;
      sync_to_monitor = "yes";
      enable_audio_bell = "no";
    };

    keybindings = {

      "ctrl+shift+e" = "kitten hints";
      "ctrl+shift+u" = "kitten unicode_input";
    };
  };
}
