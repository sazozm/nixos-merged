{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
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
  };
}
