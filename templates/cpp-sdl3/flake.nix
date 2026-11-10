{
  description = "C++ SDL3 project template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "cpp-sdl3";

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
          gcc
          gdb
          lldb
        ];

        buildInputs = with pkgs; [
          sdl3
          libGL
          wayland
          libx11
          libxcursor
          libxrandr
          libxinerama
          libxi
        ];

        shellHook = ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          export QT_QPA_PLATFORM="wayland;xcb"
          echo "C++ SDL3 dev shell loaded"
        '';
      };
    };
}
