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
      freetype
      pkgsi686Linux.freetype
    ];

    fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  };
}
