{ self, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        formatting =
          pkgs.runCommand "check-formatting"
            {
              nativeBuildInputs = [
                pkgs.nixfmt
                pkgs.findutils
              ];
            }
            ''
              cd ${self}
              nixfmt --check $(find . -type f -name '*.nix')
              touch $out
            '';

        shellcheck =
          pkgs.runCommand "check-shellcheck"
            {
              nativeBuildInputs = [ pkgs.shellcheck ];
            }
            ''
              cd ${self}
              shellcheck scripts/*.sh
              touch $out
            '';
      };
    };
}
