{
  config,
  lib,
  pkgs,
  inputs,
  username,
  stateVersion,
  homeDirectory,
  ...
}:

{
  imports = [ ./user ];
  home.stateVersion = stateVersion;

  home.username = username;
  home.homeDirectory = homeDirectory;

  programs.home-manager.enable = true;

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    LESS = "-R --use-color -Dd+r\\$Du+b";
    MANPAGER = "sh -c 'col -bx | bat -l man -p --theme=base16'";
    QT_QPA_PLATFORM = "wayland;xcb";
    GTK_IM_MODULE = "None";
    QT_IM_MODULE = "None";
    XMODIFIERS = "@im=none";
    NIXOS_OZONE_WL = "1";
  };

  programs.nixvim.nixpkgs.source = inputs.nixpkgs;
  stylix.targets.obsidian.enable = true;

  programs.sonora = {
    enable = true;
    settings = {
      provider = "youtube";
      appearance.theme = "dark";
    };
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "system-theme-switcher" ''
      WALLPAPERS="$HOME/.configs/nixos-merged/wallpapers"

      THEMES="🟣 Purple|default|$WALLPAPERS/purpleWallpaper.png
      🌾 Gruvbox Rainbow|gruvbox|$WALLPAPERS/gruvbox-dark-rainbow.png
      🌇 Cosy Sunset|sunset|$WALLPAPERS/chillhop.com-cosy_retreat_sunset.png
      🖤 Grey Lain|lain|$WALLPAPERS/grey_lain_wallpaper.jpg
      ☀️ Gruvbox Light|light|$WALLPAPERS/frieren_gruvbox.png
      💠 Blue Light|rey-light|$WALLPAPERS/rei.jpg
      🎀 Hello Kitty|kitty|$WALLPAPERS/hello_kitty.jpg"

      THEMES=$(echo "$THEMES" | sed 's/^[[:space:]]*//')

      CHOSEN=$(echo "$THEMES" | cut -d'|' -f1 | rofi -dmenu -i -p "󰸉 System Theme")
      [ -z "$CHOSEN" ] && exit 0

      LINE=$(echo "$THEMES" | grep -F -m1 "$CHOSEN|")
      SPEC=$(echo "$LINE" | cut -d'|' -f2)
      WALL=$(echo "$LINE" | cut -d'|' -f3)

      if [ "$SPEC" = "default" ]; then
        SWITCH=/nix/var/nix/profiles/system/bin/switch-to-configuration
      else
        SWITCH=/nix/var/nix/profiles/system/specialisation/"$SPEC"/bin/switch-to-configuration
      fi

      if [ ! -x "$SWITCH" ]; then
        ${pkgs.libnotify}/bin/notify-send -u critical "System Theme" "Theme '$SPEC' not found. Run nh os switch first."
        exit 1
      fi

      if ! sudo "$SWITCH" test; then
        ${pkgs.libnotify}/bin/notify-send -u critical "System Theme" "Activation reported errors. Check: systemctl status home-manager-$USER"
      fi

      noctalia msg config-reload >/dev/null 2>&1 || true
      noctalia msg wallpaper-set "$WALL" >/dev/null 2>&1 || true
      mmsg dispatch reload_config 2>/dev/null || true

      ${pkgs.libnotify}/bin/notify-send -i "$WALL" "System Theme" "Switched to: $CHOSEN"
    '')

    (writeShellScriptBin "check-themes" (builtins.readFile ../scripts/check-themes.sh))
    (writeShellScriptBin "system-health" (builtins.readFile ../scripts/system-health.sh))
    (writeShellScriptBin "measure-eval" (builtins.readFile ../scripts/measure-eval.sh))

    opencode
    vlc
    sqlite
    osu-lazer-bin
    viber
    imv
    python3
    poppler
    file
    qbittorrent
    yazi
    lazygit
    ripgrep
    wl-clipboard
    foot
    kitty
    rofi
    jq
    tmux
    direnv
    cargo
    nixd
    nixfmt
    lua-language-server
    stylua
    clang-tools
    cmake
    gdb
    lldb
    protonup-qt
    btop
    telegram-desktop
    ayugram-desktop
    kdePackages.kdenlive
    mpv
    vesktop
  ];
  programs.direnv.nix-direnv.enable = true;
}
