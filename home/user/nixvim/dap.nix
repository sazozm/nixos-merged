{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    dap = {
      enable = true;
      adapters.executables = {
        lldb = {
          command = "${pkgs.lldb}/bin/lldb-dap";
          args = [ ];
        };
        python = {
          command = "${pkgs.python3.withPackages (ps: [ ps.debugpy ])}/bin/python";
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

    dap-ui.enable = true;

    dap-virtual-text.enable = true;
  };
}
