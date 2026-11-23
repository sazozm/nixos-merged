{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
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
  };
}
