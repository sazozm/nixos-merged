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
  stylix.targets.rofi.enable = false;

  programs.sonora = {
    enable = true;
    settings = {
      provider = "youtube";
      appearance.theme = "dark";
    };
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "system-theme-switcher" (
      builtins.readFile ../scripts/system-theme-switcher.sh
    ))
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
    gh
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
