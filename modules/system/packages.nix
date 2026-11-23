{ config, inputs, ... }:

let
  module = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
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
      inputs.self.packages.x86_64-linux.vimyt
      gcc
      clang
      ninja
      (sddm-astronaut.override {
        embeddedTheme = "hyprland_kath";
      })
    ];
  };
in
{
  config.flake.nixosModules.systemPackages = module;
  config.dendrite.nixos = module;
}
