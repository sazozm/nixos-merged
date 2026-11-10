{
  description = "C++ Qt6 project template";

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
        name = "cpp-qt6";

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
          gcc
          gdb
          lldb
        ];

        buildInputs = with pkgs; [
          kdePackages.qtbase
          kdePackages.qtdeclarative
          kdePackages.qtsvg
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
          echo "C++ Qt6 dev shell loaded"
        '';
      };
    };
}
