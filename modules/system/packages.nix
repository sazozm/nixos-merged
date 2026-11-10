{ ... }:

{
  flake.nixosModules.systemPackages = { pkgs, vimyt, ... }: {
    environment.systemPackages = with pkgs; [
      (writeScriptBin "Music" ''
        #!/usr/bin/env bash
        exec ${pkgs.appimage-run}/bin/appimage-run "$HOME/.local/bin/limusic.AppImage" "$@"
      '')

      system-config-printer
      playerctl
      onlyoffice-desktopeditors
      libreoffice-stable
      jdk
      unrar
      heroic
      steam-run
      cabextract
      xdg-desktop-portal-wlr
      xdg-utils
      scrcpy
      mumble
      pulseaudio
      pavucontrol
      godot
      file-roller
      nodejs
      wineWow64Packages.stable
      winetricks
      zig
      ffmpeg
      nautilus
      pkg-config
      sfml
      wget
      git
      zoxide
      eza
      fzf
      fd
      starship
      brightnessctl
      xwayland-satellite
      fastfetch
      efibootmgr
      yt-dlp
      zip
      unzip
      p7zip
      vimyt
      gcc
      clang
      ninja
      (sddm-astronaut.override {
        embeddedTheme = "hyprland_kath";
      })
    ];
  };
}
