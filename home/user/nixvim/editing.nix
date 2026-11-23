{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    web-devicons.enable = true;

    nvim-autopairs.enable = true;

    better-escape.enable = true;

    guess-indent.enable = true;

    rainbow-delimiters.enable = true;

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

    nvim-ufo = {
      enable = true;
      setupLspCapabilities = true;
      settings.provider_selector.__raw = ''
        function(bufnr, filetype, buftype)
          return { "lsp", "indent" }
        end
      '';
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

    illuminate = {
      enable = true;
      settings = {
        delay = 250;
        large_file_cutoff = 2000;
        under_cursor = true;
      };
    };

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
  };
}
