{ ... }:

{
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      liberation_ttf
      corefonts
    ];

    fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  };
}
