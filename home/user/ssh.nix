{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        User = "git";
        IdentityFile = "/run/secrets/git_ssh_key";
        IdentitiesOnly = true;
      };
    };
  };
}
