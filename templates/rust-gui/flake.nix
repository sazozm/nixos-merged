{
  description = "Rust dev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cargo
            rustc
            rust-analyzer
            clippy
            rustfmt
            cargo-watch
            cargo-edit
            cargo-nextest
            pkg-config
            wayland
            libxkbcommon
            libGL
            fontconfig
            freetype
            alsa-lib
            vulkan-loader
            udev
            gdb
            lldb
            ripgrep
            fd
            git
          ];

          shellHook = ''
            export LD_LIBRARY_PATH=${
              pkgs.lib.makeLibraryPath [
                pkgs.wayland
                pkgs.libxkbcommon
                pkgs.libGL
                pkgs.fontconfig
                pkgs.freetype
                pkgs.alsa-lib
                pkgs.vulkan-loader
                pkgs.udev
              ]
            }:$LD_LIBRARY_PATH

            echo "   - Rust dev environment ready"
            echo "   - rustc: $(rustc --version)"
            echo "   - cargo: $(cargo --version)"
          '';
        };
      }
    );
}
