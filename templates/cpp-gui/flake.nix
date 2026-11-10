{
  description = "C++ Game & GUI Development Environment (Qt, Raylib, SFML, SDL)";

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
        name = "cpp-gamedev-env";

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
          clang-tools
          gdb
          lldb
        ];

        buildInputs = with pkgs; [
          raylib
          sfml
          SDL2
          SDL2_image
          SDL2_ttf
          SDL2_mixer
          SDL3

          kdePackages.qtbase
          kdePackages.qtdeclarative
          kdePackages.qtsvg

          libGL
          libx11
          libxcursor
          libxrandr
          libxinerama
          libxi
          wayland
        ];

        shellHook = ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          export QT_QPA_PLATFORM="wayland;xcb"
          echo " C++ Dev Environment Loaded (Qt6, Raylib, SFML, SDL2/3, CMake, Ninja)"
        '';
      };
    };
}
