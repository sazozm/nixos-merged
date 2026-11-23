{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
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
  };
}
