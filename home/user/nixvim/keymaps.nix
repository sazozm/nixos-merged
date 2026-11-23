{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
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
      {
        mode = "n";
        key = "<leader>yt";
        action = "<cmd>AerialToggle<cr>";
        options.desc = "Aerial: toggle symbol outline";
      }
    ];
  };
}
