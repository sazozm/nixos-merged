{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sazozm";
        email = "maxnovogrodskij@gmail.com";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };
}
