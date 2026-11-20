{ ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.writeShellScriptBin "nix-fmt" ''
        set -euo pipefail

        flags=()
        files=()

        for arg in "$@"; do
          case "$arg" in
            -*) flags+=("$arg") ;;
            *) files+=("$arg") ;;
          esac
        done

        if [ "''${#files[@]}" -eq 0 ]; then
          root="''${PRJ_ROOT:-$PWD}"
          while IFS= read -r file; do
            files+=("$file")
          done < <(find "$root" -type f -name '*.nix' -not -path '*/.git/*' | sort)
        fi

        if [ "''${#files[@]}" -eq 0 ]; then
          echo "nix-fmt: no .nix files found" >&2
          exit 1
        fi

        exec ${pkgs.nixfmt}/bin/nixfmt "''${flags[@]}" "''${files[@]}"
      '';
    };
}
