{ config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      termguicolors = true;
      signcolumn = "yes";
      clipboard = "unnamedplus";
      conceallevel = 2;

      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;
      splitbelow = true;
      splitright = true;
      ignorecase = true;
      smartcase = true;
      wrap = false;
      undofile = false;
      swapfile = false;
      backup = false;

      updatetime = 300;
      timeoutlen = 250;

      synmaxcol = 240;

      lazyredraw = true;
      ttyfast = true;

      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      list = true;
      listchars = "tab:→ ,trail:·,nbsp:␣";
      fillchars = "eob: ,fold: ,foldopen:▼,foldclose:▶,vert:│";
      pumheight = 10;
      confirm = true;
      mouse = "a";
      grepprg = "rg --vimgrep --no-heading";
      completeopt = "menuone,noinsert,noselect";
    };

    globals.mapleader = " ";
    globals.maplocalleader = ",";

    plugins = {
      web-devicons.enable = true;
      nvim-autopairs.enable = true;
      better-escape.enable = true;
      guess-indent.enable = true;
      rainbow-delimiters.enable = true;

      opencode = {
        enable = true;
        settings = {
          server.start.__raw = ''
            function()
              _G.opencode_toggle()
            end
          '';
        };
      };

      codecompanion = {
        enable = true;
        settings = {
          prompt_library = {
            "Memory Leak & Safety Check" = {
              strategy = "chat";
              description = "Inspect code for dangling pointers, leaks, and UB";
              opts = {
                modes = [ "v" ];
                short_name = "leak";
                auto_submit = true;
              };
              prompts = [
                {
                  role = "user";
                  content = "Inspect the following code for memory leaks, dangling pointers, buffer overflows, and undefined behavior. Suggest explicit fixes:\n\n";
                }
              ];
            };
            "Generate Docstrings" = {
              strategy = "inline";
              description = "Generate Doxygen / Rustdoc / JSDoc documentation";
              opts = {
                modes = [
                  "n"
                  "v"
                ];
                short_name = "doc";
                auto_submit = true;
              };
              prompts = [
                {
                  role = "user";
                  content = "Write comprehensive comments for this function explaining parameters and return values.";
                }
              ];
            };
          };
          strategies = {
            chat.adapter = "openrouter";
            inline.adapter = "openrouter";
          };
          interactions = {
            chat.adapter = "openrouter";
            inline.adapter = "openrouter";
          };
          adapters = {
            http = {
              openrouter.__raw = ''
                function()
                  return require("codecompanion.adapters").extend("openrouter", {
                    schema = {
                      model = {
                        default = "openrouter/free",
                      },
                    },
                    handlers = {
                      form_parameters = function(self, params, messages)
                        params.max_tokens = 4096
                        return params
                      end,
                    },
                  })
                end
              '';
            };
          };
        };
      };

      colorizer = {
        enable = true;
        settings = {
          user_default_options = {
            names = false;
            RGB = true;
            RRGGBB = true;
            RRGGBBAA = true;
            tailwind = true;
          };
        };
      };

      harpoon.enable = true;
      diffview.enable = true;

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

      nvim-ufo = {
        enable = true;
        settings.provider_selector.__raw = ''
          function(bufnr, filetype, buftype)
            return { "lsp", "indent" }
          end
        '';
      };

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
                "      █████ █     ██        █████ ██         █ ███        █████ █      ██          █████  █     █████   ██    ██"
                "   ██████  ██    ████ █  ██████  ████ █    █  ████     ██████  █    █████       ██████  █    ██████  █████ █████"
                "  ██   █  █ ██    ████  ██   █  █ ████    █  █  ███   ██   █  █       █████    ██   █  █    ██   █  █  █████ █████"
                " █    █  █  ██    █ █  █    █  █   ██    █  ██   ███ █    █  ██       █ ██    █    █  █    █    █  █   █ ██  █ ██"
                "     █  █    ██   █        █  █         █  ███    ███    █  ███      █   █        █  █         █  █    █     █"
                "    ██ ██    ██   █       ██ ██        ██   ██     ██   ██   ██      █           ██ ██        ██ ██    █     █"
                "    ██ ██     ██  █       ██ ██        ██   ██     ██   ██   ██      █           ██ ██        ██ ██    █     █"
                "    ██ ██     ██  █       ██ ██████    ██   ██     ██   ██   ██     █          ████ ██        ██ ██    █     █"
                "    ██ ██      ██ █       ██ █████     ██   ██     ██   ██   ██     █         █ ███ ██        ██ ██    █     █"
                "    ██ ██      ██ █       ██ ██        ██   ██     ██   ██   ██     █            ██ ██        ██ ██    █     ██"
                "    █  ██       ███       █  ██         ██  ██     ██    ██  ██    █        ██   ██ ██        █  ██    █     ██"
                "       █        ███          █           ██ █      █      ██ █     █       ███   █  █            █     █      ██"
                "   ████          ██      ████         █   ███     █        ███     █        ███    █         ████      █      ██"
                "  █  █████              █  ███████████     ███████          ███████          ██████         █  █████           ██"
                " █     ██              █     ██████          ███              ███              ███         █     ██"
                "█                     █                                                                   █"
                " █                     █                                                                   █"
                "  ██                    ██                                                                  ██"
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
              type = "group";
              val = [
                {
                  type = "button";
                  val = "  Find File";
                  opts.shortcut = "f";
                  on_press.__raw = "function() vim.cmd('Telescope find_files') end";
                }
                {
                  type = "button";
                  val = "  New File";
                  opts.shortcut = "n";
                  on_press.__raw = "function() vim.cmd('enew') end";
                }
                {
                  type = "button";
                  val = "  Recent Files";
                  opts.shortcut = "r";
                  on_press.__raw = "function() vim.cmd('Telescope oldfiles') end";
                }
                {
                  type = "button";
                  val = "  Live grep";
                  opts.shortcut = "g";
                  on_press.__raw = "function() vim.cmd('Telescope live_grep') end";
                }
                {
                  type = "button";
                  val = "  Exit";
                  opts.shortcut = "q";
                  on_press.__raw = "function() vim.cmd('qa') end";
                }
              ];
            }
          ];
          opts.margin = 5;
        };
      };

      spectre.enable = true;
      notify = {
        enable = true;
        settings = {
          timeout = 3000;
          max_width = 60;
          stages = "fade_in_slide_out";
          background_colour = config.lib.stylix.colors.withHashtag.base00;
          fps = 60;
        };
      };
      dressing.enable = true;
      overseer.enable = true;
      yanky.enable = true;

      zen-mode = {
        enable = true;
        settings.window.width = 0.85;
      };

      twilight.enable = true;

      smart-splits = {
        enable = true;
        settings = {
          ignored_filetypes = [
            "nofile"
            "quickfix"
            "prompt"
          ];
          ignored_buftypes = [ "nofile" ];
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          size = 15;
          open_mapping = "[[<F7>]]";
        };
      };

      aerial = {
        enable = true;
        settings.layout.max_width.__raw = "math.floor(vim.o.columns * 0.4)";
      };

      lsp = {
        enable = true;
        servers = {
          clangd = {
            enable = true;
            cmd = [
              "clangd"
              "--background-index"
              "--header-insertion=iwyu"
              "--completion-style=detailed"
              "--function-arg-placeholders"
              "-j=4"
            ];
          };
          nixd.enable = true;
          zls.enable = true;
          lua_ls.enable = true;
          marksman.enable = true;

          ts_ls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = true;
          emmet_ls.enable = true;

          tinymist.enable = true;
          hls = {
            enable = true;
            installGhc = false;
          };
          gdscript = {
            enable = true;
            package = null;
          };
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            settings = {
              diagnostics.enable = true;
              imports.granularity.group = "module";
              imports.prefix = "self";
              cargo.buildScripts.enable = true;
              procMacro.enable = true;
            };
          };
        };

        keymaps.lspBuf = {
          "K" = "hover";
          "gd" = "definition";
          "gD" = "declaration";
          "gi" = "implementation";
          "gr" = "references";
          "gy" = "type_definition";
          "gt" = "type_definition";
          "gW" = "workspace_symbol";
          "<leader>la" = "code_action";
          "<leader>ca" = "code_action";
          "<leader>lr" = "rename";
          "<leader>rn" = "rename";
          "<leader>lh" = "signature_help";
          "<leader>lI" = "incoming_calls";
          "<leader>lO" = "outgoing_calls";
          "<leader>lwa" = "add_workspace_folder";
          "<leader>lwr" = "remove_workspace_folder";
          "<leader>lwl" = "list_workspace_folders";
        };
      };

      lsp-format.enable = true;
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          formatting.clang_format.enable = true;
          formatting.nixfmt.enable = true;
          formatting.prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          diagnostics.statix.enable = true;
          diagnostics.deadnix.enable = true;
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
            "lazy"
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

      trouble.enable = true;
      todo-comments.enable = true;
      flash.enable = true;

      illuminate = {
        enable = true;
        settings = {
          delay = 250;
          large_file_cutoff = 2000;
          under_cursor = true;
        };
      };

      mini = {
        enable = true;
        autoLoad = true;
        modules = {
          surround = {
            mappings = {
              add = "gza";
              delete = "gzd";
              replace = "gzr";
              find = "gzf";
              find_left = "gzF";
              highlight = "gzh";
              update_n_lines = "gzn";
            };
          };
          ai = { };
          comment = { };
        };
      };

      treesitter = {
        enable = true;
        nixvimInjections = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent.enable = false;
          ensure_installed = [
            "c"
            "cpp"
            "rust"
            "zig"
            "python"
            "lua"
            "nix"
            "bash"
            "markdown"
            "markdown_inline"
            "json"
            "toml"
            "yaml"
            "typescript"
            "tsx"
            "javascript"
            "html"
            "css"
          ];
        };
      };

      treesitter-context = {
        enable = true;
        settings.max_lines = 2;
      };
      ts-autotag.enable = true;

      luasnip.enable = true;

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          performance = {
            debounce = 60;
            throttle = 30;
            fetching_timeout = 200;
          };
          snippet.expand = "luasnip";
          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "luasnip";
              priority = 750;
            }
            {
              name = "path";
              priority = 500;
            }
            {
              name = "buffer";
              priority = 250;
              keyword_length = 3;
              option.get_bufnrs.__raw = "function() return { vim.api.nvim_get_current_buf() } end";
            }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-u>" = "cmp.mapping.scroll_docs(-4)";
            "<C-d>" = "cmp.mapping.scroll_docs(4)";
          };
        };
      };

      dap-virtual-text.enable = true;
      dap-ui.enable = true;
      dap = {
        enable = true;
        adapters.executables = {
          lldb = {
            command = "${pkgs.lldb}/bin/lldb-dap";
            args = [ ];
          };
          python = {
            command = "${pkgs.python3Packages.debugpy}/bin/python";
            args = [
              "-m"
              "debugpy.adapter"
            ];
          };
        };
        configurations = {
          cpp = [
            {
              name = "Launch Native (C++/Qt/SFML/Raylib/SDL)";
              type = "lldb";
              request = "launch";
              program.__raw = ''
                function()
                  local cwd = vim.fn.getcwd()
                  if vim.fn.isdirectory(cwd .. "/build") == 1 then
                    return vim.fn.input("Path to binary: ", cwd .. "/build/", "file")
                  end
                  return vim.fn.input("Path to binary: ", cwd .. "/", "file")
                end
              '';
              cwd = "\${workspaceFolder}";
              stopOnEntry = false;
              args = [ ];
            }
          ];
          c = [
            {
              name = "Launch C (Raylib/SDL)";
              type = "lldb";
              request = "launch";
              program.__raw = ''
                function()
                  local cwd = vim.fn.getcwd()
                  if vim.fn.isdirectory(cwd .. "/build") == 1 then
                    return vim.fn.input("Path to binary: ", cwd .. "/build/", "file")
                  end
                  return vim.fn.input("Path to binary: ", cwd .. "/", "file")
                end
              '';
              cwd = "\${workspaceFolder}";
              stopOnEntry = false;
              args = [ ];
            }
          ];
          rust = [
            {
              name = "Launch Rust Binary";
              type = "lldb";
              request = "launch";
              program.__raw = ''
                function()
                  return vim.fn.input("Path to binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end
              '';
              cwd = "\${workspaceFolder}";
              stopOnEntry = false;
              args = [ ];
            }
          ];
          python = [
            {
              type = "python";
              request = "launch";
              name = "Launch Python file";
              program = "\${file}";
              pythonPath.__raw = ''
                function()
                  local venv = os.getenv("VIRTUAL_ENV")
                  if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
                    return venv .. "/bin/python"
                  end
                  return "${pkgs.python3}/bin/python"
                end
              '';
            }
          ];
        };
      };

      render-markdown.enable = true;
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
            __unkeyed = "<leader>u";
            group = "UI/UX";
          }
          {
            __unkeyed = "<leader>v";
            group = "Diffview";
          }
          {
            __unkeyed = "<leader>w";
            group = "Window";
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
            group = "Yank History";
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
    };

    extraPlugins = with pkgs.vimPlugins; [
      friendly-snippets
      vim-visual-multi
      nvim-window-picker
      supermaven-nvim
    ];

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
      python3
      python3Packages.debugpy

      nodejs
      live-server
      prettier
      typescript
    ];

    extraConfigLua = ''
      require("luasnip.loaders.from_vscode").lazy_load()

      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<A-l>",
          clear_suggestion = "<A-]>",
          accept_word = "<A-k>",
        },
        color = {
          suggestion_color = "#888888",
        },
        disable_inline_completion = false,
      })

      local cmp = require("cmp")
      local supermaven = require("supermaven-nvim.completion_preview")
      vim.keymap.set("i", "<Tab>", function()
        if cmp.visible() then
          cmp.select_next_item()
        elseif supermaven.has_suggestion() then
          supermaven.on_accept_suggestion()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { noremap = true, silent = true })

      vim.keymap.set("i", "<S-Tab>", function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { noremap = true, silent = true })

      local opencode_term = require("toggleterm.terminal").Terminal:new({
        cmd = "opencode --port",
        direction = "float",
        count = 42,
        hidden = true,
        close_on_exit = true,
        float_opts = { border = "rounded" },
      })

      _G.opencode_toggle = function()
        opencode_term:toggle()
      end

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "CursorLine", numhl = "" })

      local live_server_job = nil

      vim.api.nvim_create_user_command("LiveServerStart", function(opts)
        if live_server_job then
          vim.notify("Live Server is already running!", vim.log.levels.WARN)
          return
        end
        local target_dir = (opts.args and opts.args ~= "") and opts.args or vim.fn.expand("%:p:h")
        if target_dir == "" then
          target_dir = vim.fn.getcwd()
        end

        live_server_job = vim.fn.jobstart({
          "live-server",
          target_dir,
          "--port=5500",
          "--wait=200",
          "--quiet",
          "--open=."
        }, {
          detach = true,
          on_exit = function(_, code)
            live_server_job = nil
            if code ~= 0 and code ~= 143 then
              vim.notify("Live Server exited unexpectedly (code: " .. code .. ")", vim.log.levels.ERROR)
            end
          end,
        })

        vim.notify("Live Server started on http://127.0.0.1:5500\nServing: " .. target_dir, vim.log.levels.INFO)
      end, { nargs = "?" })

      vim.api.nvim_create_user_command("LiveServerStop", function()
        if live_server_job then
          vim.fn.jobstop(live_server_job)
          live_server_job = nil
          vim.notify("Live Server stopped", vim.log.levels.INFO)
        else
          vim.notify("Live Server is not running", vim.log.levels.WARN)
        end
      end, {})
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>?";
        action = "<cmd>WhichKey<cr>";
        options.desc = "Show all keymaps overlay";
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ac";
        action = "<cmd>CodeCompanionChat Toggle<cr>";
        options.desc = "Chat";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>aa";
        action = "<cmd>CodeCompanionActions<cr>";
        options.desc = "Actions palette";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ai";
        action = "<cmd>CodeCompanion<cr>";
        options.desc = "Inline Edit / Generate";
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ao";
        action.__raw = "function() require('opencode').ask('@this: ') end";
        options.desc = "OpenCode: Ask with context";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>aO";
        action.__raw = "function() require('opencode').select() end";
        options.desc = "OpenCode: Prompts / commands";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>ae";
        action.__raw = "function() require('opencode').prompt('Explain @this and its context') end";
        options.desc = "OpenCode: Explain code";
      }
      {
        mode = "n";
        key = "<leader>af";
        action.__raw = "function() require('opencode').prompt('Fix @diagnostics') end";
        options.desc = "OpenCode: Fix diagnostics";
      }
      {
        mode = "n";
        key = "<leader>at";
        action.__raw = "function() _G.opencode_toggle() end";
        options.desc = "OpenCode: Toggle TUI";
      }

      {
        mode = "n";
        key = "<F1>";
        action = "<cmd>Telescope keymaps<cr>";
        options.desc = "Search all keymaps";
      }

      {
        mode = "n";
        key = "<A-l>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<A-h>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>BufferLineCycleNext<cr>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
        options.desc = "Close buffer";
      }

      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle Explorer";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree focus<cr>";
        options.desc = "Focus Explorer";
      }
      {
        mode = "n";
        key = "<leader>er";
        action = "<cmd>Neotree reveal<cr>";
        options.desc = "Reveal file in Explorer";
      }

      {
        mode = "n";
        key = "<leader>mb";
        action = "<cmd>CMakeBuild<cr>";
        options.desc = "CMake: Build project";
      }
      {
        mode = "n";
        key = "<leader>mr";
        action = "<cmd>CMakeRun<cr>";
        options.desc = "CMake: Run active target";
      }
      {
        mode = "n";
        key = "<leader>md";
        action = "<cmd>CMakeDebug<cr>";
        options.desc = "CMake: Debug active target";
      }
      {
        mode = "n";
        key = "<leader>mg";
        action = "<cmd>CMakeGenerate<cr>";
        options.desc = "CMake: Generate (Ninja)";
      }
      {
        mode = "n";
        key = "<leader>mt";
        action = "<cmd>CMakeSelectBuildTarget<cr>";
        options.desc = "CMake: Select target";
      }
      {
        mode = "n";
        key = "<leader>mk";
        action = "<cmd>CMakeSelectKit<cr>";
        options.desc = "CMake: Select kit";
      }
      {
        mode = "n";
        key = "<leader>ms";
        action = "<cmd>CMakeSelectBuildType<cr>";
        options.desc = "CMake: Select Debug/Release";
      }
      {
        mode = "n";
        key = "<leader>mc";
        action = "<cmd>CMakeClean<cr>";
        options.desc = "CMake: Clean build";
      }
      {
        mode = "n";
        key = "<leader>mn";
        action = "<cmd>OverseerRunCmd ninja -C build<cr>";
        options.desc = "Build with Ninja directly";
      }
      {
        mode = "n";
        key = "<leader>mm";
        action = "<cmd>OverseerRunCmd make -j$(nproc)<cr>";
        options.desc = "Build with Make";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action.__raw = ''
          function()
            local cwd = vim.fn.getcwd()
            local bin = vim.fn.input("Run graphical binary: ", cwd .. "/build/", "file")
            if bin and bin ~= "" then
              vim.cmd("ToggleTerm direction=float cmd='" .. bin .. "'")
            end
          end
        '';
        options.desc = "Run App in terminal";
      }

      {
        mode = "n";
        key = "<leader>Ws";
        action = "<cmd>LiveServerStart<cr>";
        options.desc = "Live Server: Start (current folder)";
      }
      {
        mode = "n";
        key = "<leader>Wk";
        action = "<cmd>LiveServerStop<cr>";
        options.desc = "Live Server: Stop / Kill";
      }
      {
        mode = "n";
        key = "<leader>Wt";
        action = "<cmd>ToggleTerm direction=float cmd='npm run dev || npx vite'<cr>";
        options.desc = "Run dev server in terminal (Vite / Next)";
      }

      {
        mode = "n";
        key = "<F5>";
        action.__raw = "function() require('dap').continue() end";
        options.desc = "Debug: Continue / Start";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw = "function() require('dap').continue() end";
        options.desc = "Start/Continue";
      }
      {
        mode = "n";
        key = "<F9>";
        action.__raw = "function() require('dap').toggle_breakpoint() end";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>db";
        action.__raw = "function() require('dap').toggle_breakpoint() end";
        options.desc = "Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<F10>";
        action.__raw = "function() require('dap').step_over() end";
        options.desc = "Step Over";
      }
      {
        mode = "n";
        key = "<leader>ds";
        action.__raw = "function() require('dap').step_over() end";
        options.desc = "Step Over";
      }
      {
        mode = "n";
        key = "<F11>";
        action.__raw = "function() require('dap').step_into() end";
        options.desc = "Step Into";
      }
      {
        mode = "n";
        key = "<leader>di";
        action.__raw = "function() require('dap').step_into() end";
        options.desc = "Step Into";
      }
      {
        mode = "n";
        key = "<leader>dO";
        action.__raw = "function() require('dap').step_out() end";
        options.desc = "Step Out";
      }
      {
        mode = "n";
        key = "<leader>du";
        action.__raw = "function() require('dapui').toggle() end";
        options.desc = "Toggle DAP UI";
      }
      {
        mode = "n";
        key = "<leader>dh";
        action.__raw = "function() require('dap.ui.widgets').hover() end";
        options.desc = "Debug Hover Info";
      }
      {
        mode = "n";
        key = "<leader>dQ";
        action.__raw = "function() require('dap').terminate() end";
        options.desc = "Terminate Debug";
      }

      {
        mode = "n";
        key = "|";
        action = "<cmd>vsplit<cr>";
        options.desc = "Vertical Split";
      }
      {
        mode = "n";
        key = "\\";
        action = "<cmd>split<cr>";
        options.desc = "Horizontal Split";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear search highlight";
      }
      {
        mode = "n";
        key = "Y";
        action = "y$";
        options.desc = "Yank to end of line";
      }

      {
        mode = "n";
        key = "<C-h>";
        action.__raw = "function() require('smart-splits').move_cursor_left() end";
      }
      {
        mode = "n";
        key = "<C-j>";
        action.__raw = "function() require('smart-splits').move_cursor_down() end";
      }
      {
        mode = "n";
        key = "<C-k>";
        action.__raw = "function() require('smart-splits').move_cursor_up() end";
      }
      {
        mode = "n";
        key = "<C-l>";
        action.__raw = "function() require('smart-splits').move_cursor_right() end";
      }

      {
        mode = "n";
        key = "<leader>ld";
        action.__raw = "function() vim.diagnostic.open_float() end";
        options.desc = "Line Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>D";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options.desc = "Buffer Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>xt";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Trouble: Workspace diagnostics";
      }
      {
        mode = "n";
        key = "<leader>xs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options.desc = "Trouble: Symbols";
      }

      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "LazyGit";
      }
      {
        mode = "n";
        key = "<leader>vv";
        action = "<cmd>DiffviewOpen<cr>";
        options.desc = "Diffview: Open";
      }
      {
        mode = "n";
        key = "<leader>vc";
        action = "<cmd>DiffviewClose<cr>";
        options.desc = "Diffview: Close";
      }
      {
        mode = "n";
        key = "<leader>vh";
        action = "<cmd>DiffviewFileHistory %<cr>";
        options.desc = "Diffview: File history";
      }
      {
        mode = "n";
        key = "<leader>zz";
        action = "<cmd>ZenMode<cr>";
        options.desc = "Zen mode toggle";
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>Spectre<cr>";
        options.desc = "Search & replace (Spectre)";
      }

      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action.__raw = "function() require('flash').jump() end";
        options.desc = "Flash jump";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "S";
        action.__raw = "function() require('flash').treesitter() end";
        options.desc = "Flash Treesitter";
      }

      {
        mode = "n";
        key = "<leader>ha";
        action.__raw = "function() require('harpoon'):list():add() end";
        options.desc = "Harpoon: Add file";
      }
      {
        mode = "n";
        key = "<leader>hh";
        action.__raw = "function() local h = require('harpoon') h.ui:toggle_quick_menu(h:list()) end";
        options.desc = "Harpoon: Menu";
      }
      {
        mode = "n";
        key = "<leader>h1";
        action.__raw = "function() require('harpoon'):list():select(1) end";
        options.desc = "Harpoon 1";
      }
      {
        mode = "n";
        key = "<leader>h2";
        action.__raw = "function() require('harpoon'):list():select(2) end";
        options.desc = "Harpoon 2";
      }
      {
        mode = "n";
        key = "<leader>h3";
        action.__raw = "function() require('harpoon'):list():select(3) end";
        options.desc = "Harpoon 3";
      }
      {
        mode = "n";
        key = "<leader>h4";
        action.__raw = "function() require('harpoon'):list():select(4) end";
        options.desc = "Harpoon 4";
      }

      {
        mode = "n";
        key = "<leader>rr";
        action = "<cmd>OverseerRun<cr>";
        options.desc = "Run task";
      }
      {
        mode = "n";
        key = "<leader>rt";
        action = "<cmd>OverseerToggle<cr>";
        options.desc = "Toggle task list";
      }
      {
        mode = "n";
        key = "<leader>rc";
        action = "<cmd>OverseerRunCmd<cr>";
        options.desc = "Run custom shell command";
      }

      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>ToggleTerm direction=float<cr>";
        options.desc = "Float Terminal";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<cr>";
        options.desc = "Horizontal Terminal";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical size=45<cr>";
        options.desc = "Vertical Terminal";
      }

      {
        mode = "n";
        key = "<leader>on";
        action = "<cmd>ObsidianNew<cr>";
        options.desc = "Obsidian: New Note";
      }
      {
        mode = "n";
        key = "<leader>os";
        action = "<cmd>ObsidianSearch<cr>";
        options.desc = "Obsidian: Search Notes";
      }
      {
        mode = "n";
        key = "<leader>oo";
        action = "<cmd>ObsidianOpen<cr>";
        options.desc = "Obsidian: Open in App";
      }
    ];
  };
}
