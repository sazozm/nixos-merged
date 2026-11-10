{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      manager = {
        ratio = [
          1
          3
          4
        ];
        show_hidden = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        linemode = "size";
        scrolloff = 5;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
        wrap = "yes";
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "g"
            "c"
          ];
          run = "cd ~/.config";
          desc = "dir";
        }
        {
          on = [ "T" ];
          run = "plugin --sync max-preview";
          desc = "full";
        }
      ];
    };
  };
}
