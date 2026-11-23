{ inputs, ... }:

let
  telegramTemplate = ../../templates/matugen/telegram.tdesktop-theme;

  home =
    { config, pkgs, ... }:
    let
      matugen = inputs.matugen.packages.${pkgs.stdenv.hostPlatform.system}.default;
      color = config.lib.stylix.colors.base0E;
      mode = config.stylix.polarity;

      telegramTheme =
        pkgs.runCommand "telegram-stylix-theme"
          {
            nativeBuildInputs = [ matugen ];
          }
          ''
            mkdir -p "$out"
            cp ${telegramTemplate} template.tdesktop-theme
            cat > config.toml <<EOF
            [config]
            [templates.telegram]
            input_path = "template.tdesktop-theme"
            output_path = "$out/stylix.tdesktop-theme"
            EOF
            HOME="$TMPDIR" matugen color hex "${color}" -m "${mode}" -c config.toml
          '';
    in
    {
      home.packages = [ matugen ];

      xdg.dataFile."TelegramDesktop/themes/stylix.tdesktop-theme".source =
        "${telegramTheme}/stylix.tdesktop-theme";
      xdg.dataFile."AyuGramDesktop/themes/stylix.tdesktop-theme".source =
        "${telegramTheme}/stylix.tdesktop-theme";
    };
in
{
  config.dendrite.home = home;
}
