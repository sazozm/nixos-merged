{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeCBin "gpu-stats-script" (builtins.readFile ../../scripts/gpu-stats-script.c))
    (pkgs.writeShellScriptBin "get-language" ''
      echo $(mmsg get keyboardlayout | grep -oP '(?<="layout":")[A-Za-z]+')
    '')
  ];

  programs.waybar = {
    enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 1;
        height = 32;

        margin-top = 5;
        margin-left = 30;
        margin-right = 30;
        margin-bottom = 2;
        exclusive-zone = 44;

        modules-left = [
          "ext/workspaces"
          "clock"
          "bluetooth"
          "mango/window"
          "custom/language"
        ];
        modules-center = [ "mpris" ];
        modules-right = [
          "network"
          "battery"
          "cpu"
          "temperature"
          "memory"
          "wireplumber"
          "disk"
          "backlight"
          "tray"
        ];

        "custom/language" = {
          exec = "get-language";
          interval = 3;
          format = "{text}";
        };

        keyboard-state = {
          capslock = true;
          format = "{name}{icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
          tooltip = false;
        };

        "ext/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
          };
          ignore-hidden = true;
          on-click = "activate";
          on-click-right = "deactivate";
          sort-by-id = true;
        };

        "mango/window" = {
          format = "{title}";

          icon = true;
          rewrite = {
            "(.*)Mozilla Firefox(.*)" = "Firefox";
            "(.*)Chromium(.*)" = "Chromium";
            "(.*)nvim(.*)" = "Neovim";
            "(.*)helix(.*)" = "Helix";
            "(.*)alacritty(.*)" = "Alacritty";
            "(.*)kitty(.*)" = "Kitty";
            "(.*)foot(.*)" = "Foot";
            "(.*)Telegram(.*)" = "Telegram";
            "(.*)Discord(.*)" = "Discord";
            "(.*)Vesktop(.*)" = "Vesktop";
            "(.*)Spotify(.*)" = "Spotify";
            "(.*)mpv(.*)" = "mpv";
            "(.*)Steam(.*)" = "Steam";
            "(.*)- GIMP$" = "GIMP";
            "(.*)Thunar(.*)" = "Thunar";
            "(.*)fish(.*)" = "Fish-Shell";
            "^$" = "Desktop";
          };
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "󰐊";
            chromium = "󰐊";
            firefox = "󰐊";
          };
          status-icons = {
            paused = "󰏤";
          };
          dynamic-order = [
            "title"
            "artist"
          ];
          dynamic-len = 45;
          ellipsis = "…";
        };

        network = {
          interval = 3;
          format-wifi = "{signalStrength}%";
          format-ethernet = "󰈀{ipaddr}";
          format-disconnected = "󰤭 off";
          tooltip-format-wifi = "{essid}  {signalStrength}%\n󰇚 {bandwidthDownBytes}   󰕒 {bandwidthUpBytes}";
          tooltip-format-ethernet = "{ifname}  {ipaddr}\n󰇚 {bandwidthDownBytes}   󰕒 {bandwidthUpBytes}";
          tooltip-format-disconnected = "disconnected";
        };

        cpu = {
          format = "󰻠 {usage}%";
          interval = 2;
          tooltip-format = "{usage}%  load {load}";
          on-click = "foot -e fish -c 'btop; exec fish'";
        };

        temperature = {
          hwmon-path = [
            "/sys/class/hwmon/hwmon1/temp1_input"
            "/sys/class/hwmon/hwmon2/temp1_input"
            "/sys/class/hwmon/hwmon3/temp1_input"
            "/sys/class/hwmon/hwmon4/temp1_input"
            "/sys/class/hwmon/hwmon0/temp1_input"
          ];
          critical-threshold = 85;
          interval = 3;
          format = "󰔏 {temperatureC}°";
          format-critical = "󰸁 {temperatureC}°";
          tooltip = false;
        };

        "custom/gpu" = {
          exec = "gpu-stats-script";
          return-type = "json";
          interval = 3;
          format = "󰾲 {text}";
          tooltip = true;
          on-click = "foot -e fish -c 'watch -n1 nvidia-smi || radeontop; exec fish'";
        };

        memory = {
          format = "󰍛 {percentage}%";
          interval = 5;
          tooltip-format = "{used:0.1f}G / {total:0.1f}G\nswap {swapUsed:0.1f}G / {swapTotal:0.1f}G";
          on-click = "foot -e fish -c 'btop; exec fish'";
        };

        wireplumber = {
          scroll-step = 1;
          max-volume = 110;
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "󰋋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          tooltip-format = "{node_name}";
        };

        battery = {
          bat = "BAT0";
          interval = 30;
          format = "{icon} {capacity}% ";
          format-full = "{icon} {capacity}%";
          format-charging = "󱐋 {capacity}% ";
          format-icons = [
            "󰁺"
            "󰁼"
            "󰁾"
            "󰁾"
            "󰂀"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        clock = {
          interval = 30;
          format = "󰥔 {:%H·%M}";
          format-alt = "󰃭 {:%d·%m·%Y}";
          tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            weeks-pos = "left";
            on-scroll = 1;
            format = {
              months = "<b>{}</b>";
              days = "{}";
              weeks = "<b>W{}</b>";
              weekdays = "<b>{}</b>";
              today = "<b><u>{}</u></b>";
            };
          };
        };

        bluetooth = {
          format = "󰂯 {status}";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\n{num_connections} connected\n{device_enumerate}";
          on-click = "blueman-manager";
        };

        disk = {
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/";
          tooltip-format = "{used} / {total}";
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
        };

        tray = {
          icon-size = 15;
          spacing = 6;
          show-passive-items = true;
        };
      }
    ];

    style = ''
      * {
          font-weight: 500;
          border: none;
          border-radius: 10px;
          min-height: 0;
      }

      window#waybar {
          background-color: @base00;
          color: @base05;
          border-radius: 0px;
          border: 2px solid @base02;
      }

      .modules-left   { margin: 5px 0px 4px 5px; }
      .modules-center { margin: 5px 0 4px 0;   }
      .modules-right  { margin: 5px 5px 4px 0; }

      #custom-power, #workspaces, #keyboard-state, #custom-language, #window,
      #mpris, #network, #cpu, #temperature, #custom-gpu, #memory,
      #wireplumber, #battery, #idle_inhibitor, #disk, #clock, #bluetooth,
      #backlight, #tray {
          background-color: @base01;
          color: @base05;
          padding: 0 10px;
          border-radius: 5px;
          margin-left: 4px;
      }

      #customlanguage {
          padding: 0 10px;
          border-bottom: 1px solid @base02;
          transition: all 0.3s ease;
      }
      #custom-language.Russian { color: @base08; border-bottom: 1px solid @base05; }
      #custom-language.English { color: @base0B; border-bottom: 1px solid @base0B; }

      #keyboard-state {
          padding: 0 8px;
          color: @base03;
          border-bottom: 1px solid @base02;
          transition: all 0.3s ease;
      }
      #keyboard-state.locked { color: @base0E; animation: capslock-gradient 3s ease-in-out infinite; }

      @keyframes capslock-gradient {
          0%   { border-bottom-color: @base02; text-shadow: none; }
          50%  { border-bottom-color: @base0E; text-shadow: 0 0 5px @base0E; }
          100% { border-bottom-color: @base02; text-shadow: none; }
      }

      #workspaces { padding: 0 2px; border-radius: 5px; margin-left: 0; }
      #workspaces button {
          padding: 0 7px; background-color: transparent; color: @base03;
          border-radius: 4px; font-size: 11px; min-width: 22px; margin: 2px 1px;
      }
      #workspaces button:hover { background-color: @base02; color: @base04; box-shadow: none; }
      #workspaces button.active { background-color: @base02; color: @base0B; }
      #workspaces button.visible { background-color: transparent; color: @base04; }
      #workspaces button.occupied { color: @base03; }
      #workspaces button.hidden { color: transparent; min-width: 0; padding: 0; margin: 0; }
      #workspaces button.urgent { background-color: @base02; color: @base08; }

      #window { color: @base04; font-weight: 400; font-size: 11px; min-width: 60px; }

      #mpris { font-size: 12px; font-weight: 400; padding: 0 12px; min-width: 10px; }
      #mpris.off { background-color: transparent; color: transparent; padding: 0; margin: 0; min-width: 0; border: none; }
      #mpris.playing { background-color: @base01; color: @base0B; border: 1px solid @base0B; animation: music-breathe 4s ease-in-out infinite; }
      #mpris.paused { background-color: @base01; color: @base03; border: 1px solid @base02; }

      @keyframes music-breathe { 0% { border-color: @base02; } 50% { border-color: @base0B; } 100% { border-color: @base02; } }

      #network { color: @base0D; }
      #network.disconnected { color: @base08; opacity: 0.5; }
      #cpu { color: @base04; }
      #cpu.warning { color: @base0A; }
      #cpu.critical { color: @base08; }
      #temperature { color: @base04; }
      #temperature.critical { color: @base08; animation: blink 1s linear infinite; }
      #custom-gpu { color: @base04; }
      #custom-gpu.warning { color: @base0A; }
      #custom-gpu.critical { color: @base08; animation: blink 1s linear infinite; }
      #custom-gpu.off { color: @base03; }
      #memory { color: @base04; }
      #memory.warning { color: @base0A; }
      #memory.critical { color: @base08; }

      #wireplumber { color: @base0E; }
      #wireplumber.muted { color: @base03; background-color: @base01; }

      #battery { font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", monospace; color: @base04; }
      #battery.charging { color: @base0B; }
      #battery.warning { color: @base0A; }
      #battery.critical { color: @base08; animation: blink 1s linear infinite; }
      #battery.full { color: @base0B; }

      #clock { color: @base05; letter-spacing: 1px; border-bottom: 1px solid @base02; animation: clock-breathe 10s ease-in-out infinite; }
      @keyframes clock-breathe { 0% { border-color: @base02; } 50% { border-color: @base0E; } 100% { border-color: @base02; } }

      #tray { padding: 0 6px; }
      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; background-color: @base02; border-radius: 4px; }

      tooltip { background-color: @base01; color: @base05; border: 1px solid @base02; border-radius: 5px; }
      @keyframes blink { 0% { opacity: 1; } 50% { opacity: 0.3; } 100% { opacity: 1; } }

    '';
  };
}
