{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    alpha = {
      enable = true;
      settings = {
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = [
              "  ██████╗ ██╗   ██╗██╗     ██╗"
              "  ██╔══██╗██║   ██║██║     ██║"
              "  ██████╔╝██║   ██║██║     ██║"
              "  ██╔══██╗██║   ██║██║     ██║"
              "  ██████╔╝╚██████╔╝███████╗███████╗"
              "  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝"
            ];
            opts = {
              position = "center";
              hl = "Type";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = "  ──────────────────  actions  ──────────────────";
            opts = {
              position = "center";
              hl = "Label";
            };
          }
          {
            type = "padding";
            val = 1;
          }
          {
            type = "group";
            opts = {
              spacing = 1;
              "inherit" = {
                position = "center";
                width = 50;
              };
            };
            val = [
              {
                type = "button";
                val = "    Find File";
                opts.shortcut = "f";
                on_press.__raw = "function() vim.cmd('Telescope find_files') end";
              }
              {
                type = "button";
                val = "    New File";
                opts.shortcut = "n";
                on_press.__raw = "function() vim.cmd('enew') end";
              }
              {
                type = "button";
                val = "    Recent Files";
                opts.shortcut = "r";
                on_press.__raw = "function() vim.cmd('Telescope oldfiles') end";
              }
              {
                type = "button";
                val = "    Live grep";
                opts.shortcut = "g";
                on_press.__raw = "function() vim.cmd('Telescope live_grep') end";
              }
              {
                type = "button";
                val = "    Git status";
                opts.shortcut = "s";
                on_press.__raw = "function() vim.cmd('Telescope git_status') end";
              }
              {
                type = "button";
                val = "    Terminal";
                opts.shortcut = "t";
                on_press.__raw = "function() vim.cmd('ToggleTerm direction=float') end";
              }
              {
                type = "button";
                val = "    Edit config";
                opts.shortcut = "c";
                on_press.__raw = ''
                  function()
                    vim.cmd.edit(vim.fn.expand("~/.configs/nixos-merged/home/user/nixvim.nix"))
                  end
                '';
              }
              {
                type = "button";
                val = "    Exit";
                opts.shortcut = "q";
                on_press.__raw = "function() vim.cmd('qa') end";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
        ];
        opts.margin = 5;
      };
    };

    bufferline = {
      enable = true;
      settings.options = {
        mode = "buffers";
        diagnostics = "nvim_lsp";
        separator_style = "slant";
        always_show_bufferline = true;
        show_buffer_icons = true;
        show_buffer_close_icons = true;
        show_close_icon = false;
        color_icons = true;
        indicator = {
          style = "icon";
          icon = "▎";
        };
        buffer_close_icon = "";
        modified_icon = "●";
        close_icon = "";
        left_trunc_marker = "";
        right_trunc_marker = "";
        tab_size = 20;
        offsets = [
          {
            filetype = "neo-tree";
            text = "File Explorer";
            text_align = "left";
            separator = true;
          }
        ];
      };
    };

    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "auto";
          globalstatus = true;
          icons_enabled = true;
          component_separators = {
            left = "";
            right = "";
          };
          section_separators = {
            left = "";
            right = "";
          };
          disabled_filetypes.statusline = [
            "alpha"
            "dashboard"
            "neo-tree"
          ];
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
            "diagnostics"
          ];
          lualine_c = [
            "filename"
            "lsp_status"
          ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
        extensions = [
          "neo-tree"
          "quickfix"
          "toggleterm"
          "trouble"
        ];
      };
    };

    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "│";
          tab_char = "│";
        };
        scope = {
          enabled = true;
          show_start = false;
          show_end = false;
        };
        whitespace.remove_blankline_trail = false;
      };
    };

    neo-tree = {
      enable = true;
      settings = {
        enable_git_status = true;
        enable_diagnostics = false;
        close_if_last_window = true;
        window.width = 30;
      };
    };

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fw" = "grep_string";
        "<leader>fc" = "grep_string";
        "<leader>fb" = "buffers";
        "<leader>fo" = "oldfiles";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";
        "<leader>fs" = "git_status";
        "<leader>f:" = "commands";
        "<leader>fk" = "keymaps";
        "<leader>fr" = "resume";
        "<leader>fz" = "current_buffer_fuzzy_find";
        "<leader>fj" = "jumplist";
        "<leader>fq" = "quickfix";
        "<leader>fT" = "treesitter";
        "<leader>fL" = "lsp_references";
      };
    };

    which-key = {
      enable = true;
      settings.spec = [
        {
          __unkeyed = "<leader>a";
          group = "Assistants";
        }
        {
          __unkeyed = "<leader>b";
          group = "Buffers";
        }
        {
          __unkeyed = "<leader>c";
          group = "Code / Actions";
        }
        {
          __unkeyed = "<leader>d";
          group = "Debugger";
        }
        {
          __unkeyed = "<leader>f";
          group = "Find";
        }
        {
          __unkeyed = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed = "<leader>h";
          group = "Harpoon";
        }
        {
          __unkeyed = "<leader>l";
          group = "LSP";
        }
        {
          __unkeyed = "<leader>m";
          group = "Build / CMake / Make / Ninja";
        }
        {
          __unkeyed = "<leader>r";
          group = "Run / Tasks / Overseer";
        }
        {
          __unkeyed = "<leader>s";
          group = "Search & Replace";
        }
        {
          __unkeyed = "<leader>t";
          group = "Terminal";
        }
        {
          __unkeyed = "<leader>v";
          group = "Diffview";
        }
        {
          __unkeyed = "<leader>W";
          group = "Web / Live Server";
        }
        {
          __unkeyed = "<leader>x";
          group = "Trouble";
        }
        {
          __unkeyed = "<leader>y";
          group = "Symbols";
        }
        {
          __unkeyed = "<leader>z";
          group = "Zen Mode";
        }
        {
          __unkeyed = "<leader>o";
          group = "Obsidian / Notes";
        }
      ];
    };

    flash.enable = true;

    harpoon.enable = true;

    diffview.enable = true;
  };
}
