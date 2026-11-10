{ config, pkgs, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
  xdg.configFile."user-dirs.dirs".force = true;
  xdg.configFile."gtk-3.0/gtk.css".force = true;
  xdg.configFile."gtk-4.0/gtk.css".force = true;
  xdg.configFile."mango/config.conf".force = true;

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/tg" = [ "org.ayugram.desktop.desktop" ];
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      inline_height = 15;
      enter_accept = false;
    };
  };

  stylix.targets.fzf.enable = false;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidget.command = "fd --type f --hidden --follow --exclude .git";
    changeDirWidget.command = "fd --type d --hidden --follow --exclude .git";
    historyWidget.command = "";
    defaultOptions = [
      "--color=bg+:${c.base02},bg:${c.base00},spinner:${c.base0E},hl:${c.base0B}"
      "--color=fg:${c.base05},header:${c.base0C},info:${c.base0E},pointer:${c.base05}"
      "--color=marker:${c.base0B},prompt:${c.base0E},hl+:${c.base0C},border:${c.base02}"
      "--height=40%"
      "--layout=reverse"
      "--border=rounded"
      "--prompt='❯ '"
      "--pointer='▶'"
      "--marker='✓'"
    ];
  };

  programs.bat.enable = true;

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        padding = {
          top = 1;
          right = 2;
        };
      };
      display = {
        separator = "  ";
        color = "cyan";
      };
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "  OS";
          keyColor = "magenta";
        }
        {
          type = "kernel";
          key = "  Kernel";
          keyColor = "magenta";
        }
        {
          type = "uptime";
          key = "  Uptime";
          keyColor = "magenta";
        }
        {
          type = "packages";
          key = "  Packages";
          keyColor = "magenta";
        }
        {
          type = "shell";
          key = "  Shell";
          keyColor = "magenta";
        }
        {
          type = "wm";
          key = "  WM";
          keyColor = "magenta";
        }
        {
          type = "terminal";
          key = "  Terminal";
          keyColor = "magenta";
        }
        {
          type = "cpu";
          key = "  CPU";
          keyColor = "magenta";
        }
        {
          type = "gpu";
          key = "  GPU";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "  Memory";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  Disk";
          keyColor = "magenta";
        }
        "break"
        "colors"
      ];
    };
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  home.packages = with pkgs; [
    mission-center
    gnome-disk-utility
    baobab
    gnome-calculator
    qalculate-gtk
    nwg-displays
    udiskie
    libnotify
    hyprpicker
    wev
    dust
    duf
    procs
    ncdu
    hyperfine
  ];
}
