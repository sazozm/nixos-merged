{ ... }:

{
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

        launcher.dmenu.entry.theme = {
          command = "system-theme-switcher --list";
          exec = "system-theme-switcher --apply \"{selection}\"";
          prefix = "theme";
          label = "System Theme";
          glyph = "palette";
          global = false;
        };
      };

      appLauncher = {
        enableClipPreview = true;
        iconMode = "tabler";
        showCategories = true;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        viewMode = "list";
      };

      audio = {
        cavaFrameRate = 30;
        externalMixer = "pwvucontrol || pavucontrol";
        visualizerType = "linear";
        volumeStep = 5;
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
