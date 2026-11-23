{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    cmake-tools = {
      enable = true;
      settings = {
        cmake_build_directory = "build";
        cmake_generate_options.__raw = ''{ "-GNinja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }'';
        cmake_build_options.__raw = ''{ "-j" }'';
        cmake_console_size = 12;
        cmake_show_console = "always";
      };
    };

    overseer.enable = true;

    obsidian = {
      enable = true;
      settings = {
        legacy_commands = false;
        workspaces = [
          {
            name = "Notes";
            path = "~/Notes";
          }
        ];
        daily_notes = {
          folder = "Daily";
          date_format = "%Y-%m-%d";
        };
        completion.min_chars = 2;
        ui.enable = false;
      };
    };

    render-markdown.enable = true;

    lazygit.enable = true;

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "_";
        };
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 800;
          virt_text_pos = "eol";
        };
      };
    };

    trouble.enable = true;

    todo-comments.enable = true;
  };
}
