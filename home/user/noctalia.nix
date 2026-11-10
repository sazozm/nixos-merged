{ config, inputs, ... }:

let
  c = config.lib.stylix.colors.withHashtag;

  variant = {
    mPrimary = c.base0E;
    mOnPrimary = c.base00;
    mSecondary = c.base0D;
    mOnSecondary = c.base00;
    mTertiary = c.base0B;
    mOnTertiary = c.base00;
    mError = c.base08;
    mOnError = c.base00;
    mSurface = c.base00;
    mOnSurface = c.base05;
    mSurfaceVariant = c.base01;
    mOnSurfaceVariant = c.base04;
    mOutline = c.base03;

    mHover = c.base02;
    mOnHover = c.base05;
    terminal = {
      background = c.base00;
      foreground = c.base05;
      cursor = c.base05;
      cursorText = c.base00;
      selectionBackground = c.base02;
      selectionForeground = c.base05;
      normal = {
        black = c.base00;
        red = c.base08;
        green = c.base0B;
        yellow = c.base0A;
        blue = c.base0D;
        magenta = c.base0E;
        cyan = c.base0C;
        white = c.base05;
      };
      bright = {
        black = c.base03;
        red = c.base08;
        green = c.base0B;
        yellow = c.base0A;
        blue = c.base0D;
        magenta = c.base0E;
        cyan = c.base0C;
        white = c.base07;
      };
    };
  };

  palette = builtins.toJSON {
    dark = variant;
    light = variant;
  };
in
{
  xdg.configFile."noctalia/palettes/Stylix.json" = {
    text = palette;
    force = true;
  };

  xdg.configFile."noctalia/colorschemes/Stylix/Stylix.json" = {
    text = palette;
    force = true;
  };

  programs.noctalia = {
    enable = true;

    settings = {
      shell = {
        corner_radius_scale = 0;
        animation = {
          enabled = true;
          speed = 1.15;
        };
        shadow = {
          direction = "down";
          alpha = 0.5;
        };
        panel = {
          transparency_mode = "glass";
          borders = true;
          border_width = 1.0;
          shadow = true;
        };
      };

      backdrop = {
        enabled = false;
        blur_intensity = 0.45;
        tint_intensity = 0.3;
      };

      notification = {
        border = true;
        border_width = 1;
      };

      osd = {
        border = true;
        border_width = 1;
        hide_delay_ms = 1500;
      };

      wallpaper = {
        enabled = true;
        transition = [
          "fade"
          "zoom"
        ];
        transition_duration = 900;
      };
    };
  };
}
