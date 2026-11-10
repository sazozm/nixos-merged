{ pkgs, ... }:

{
  programs.helix = {
    enable = true;

    extraPackages = with pkgs; [
      clang-tools
      cmake
      ninja
      gnumake
      gdb
      lldb
      ripgrep
      fd
      rustc
      rustfmt
      clippy
      cargo
      nixd
      nixfmt
      zls
      lua-language-server
      marksman
      statix
      deadnix
      rust-analyzer

      bash-language-server
      shfmt
      shellcheck

      vscode-langservers-extracted
      prettier

      taplo

      fish-lsp
      fish

      lemminx

      yaml-language-server

      neocmakelsp
      gersemi

      ruff
      pyright

      systemd-lsp
    ];

    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 8;
        color-modes = true;
        idle-timeout = 100;
        true-color = true;

        indent-guides = {
          render = true;
          character = "│";
        };

        whitespace = {
          render = "all";
          characters = {
            tab = "→";
            tabpad = " ";
            nbsp = "␣";
            space = "·";
            enter = "";
          };
        };

        soft-wrap.enable = false;
        search.smart-case = true;
        bufferline = "multiple";
        rulers = [
          80
          100
        ];

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        file-picker = {
          hidden = false;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          center = [ ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-type"
          ];
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };

      keys = {
        normal = {
          "|" = "vsplit";
          "\\" = "hsplit";
          "H" = "goto_previous_buffer";
          "L" = "goto_next_buffer";
          "space" = {
            "q" = ":q";
            "c" = ":bc";
            "o" = ":bco";
            "f" = {
              "f" = "file_picker";
              "g" = "global_search";
              "b" = "buffer_picker";
            };
          };
        };
      };
    };

    languages = {
      language-server = {
        clangd = {
          command = "clangd";
        };
        nixd = {
          command = "nixd";
        };
        zls = {
          command = "zls";
        };
        lua-language-server = {
          command = "lua-language-server";
        };
        marksman = {
          command = "marksman";
        };
        rust-analyzer = {
          command = "rust-analyzer";
          config.rust-analyzer = {
            diagnostics.enable = true;
            imports.granularity.group = "module";
            imports.prefix = "self";
            cargo.buildScripts.enable = true;
            procMacro.enable = true;
          };
        };
        bash-language-server = {
          command = "bash-language-server";
          args = [ "start" ];
        };
        vscode-css-language-server = {
          command = "vscode-css-language-server";
          args = [ "--stdio" ];
        };
        taplo = {
          command = "taplo";
          args = [
            "lsp"
            "stdio"
          ];
        };
        fish-lsp = {
          command = "fish-lsp";
          args = [ "start" ];
        };
        lemminx = {
          command = "lemminx";
        };
        yaml-language-server = {
          command = "yaml-language-server";
          args = [ "--stdio" ];
        };
        neocmakelsp = {
          command = "neocmakelsp";
          args = [ "--stdio" ];
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };
        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };
        systemd-lsp = {
          command = "systemd-lsp";
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
          language-servers = [ "nixd" ];
        }
        {
          name = "cpp";
          auto-format = true;
          language-servers = [ "clangd" ];
          debugger = {
            name = "lldb-dap";
            transport = "stdio";
            command = "lldb-dap";
            templates = [
              {
                name = "Launch";
                request = "launch";
                completion = [
                  {
                    name = "binary";
                    completion = "filename";
                  }
                ];
                args = {
                  program = "{0}";
                  runInTerminal = false;
                };
              }
            ];
          };
        }
        {
          name = "c";
          auto-format = true;
          language-servers = [ "clangd" ];
          debugger = {
            name = "lldb-dap";
            transport = "stdio";
            command = "lldb-dap";
            templates = [
              {
                name = "Launch";
                request = "launch";
                completion = [
                  {
                    name = "binary";
                    completion = "filename";
                  }
                ];
                args = {
                  program = "{0}";
                  runInTerminal = false;
                };
              }
            ];
          };
        }
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "rustfmt";
          };
          language-servers = [
            "rust-analyzer"
          ];
        }
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = [
              "-i"
              "2"
            ];
          };
          language-servers = [ "bash-language-server" ];
        }
        {
          name = "css";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "css"
            ];
          };
          language-servers = [ "vscode-css-language-server" ];
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "taplo";
            args = [
              "fmt"
              "-"
            ];
          };
          language-servers = [ "taplo" ];
        }
        {
          name = "fish";
          auto-format = true;
          formatter = {
            command = "fish_indent";
          };
          language-servers = [ "fish-lsp" ];
        }
        {
          name = "xml";
          auto-format = true;
          language-servers = [ "lemminx" ];
        }
        {
          name = "yaml";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "yaml"
            ];
          };
          language-servers = [ "yaml-language-server" ];
        }
        {
          name = "cmake";
          auto-format = true;
          formatter = {
            command = "gersemi";
            args = [ "-" ];
          };
          language-servers = [ "neocmakelsp" ];
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
          language-servers = [
            "ruff"
            "pyright"
          ];
        }
        {
          name = "pkgbuild";
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = [
              "-i"
              "2"
            ];
          };
          language-servers = [ "bash-language-server" ];
        }
        {
          name = "systemd";
          language-servers = [ "systemd-lsp" ];
        }
      ];
    };
  };
}
