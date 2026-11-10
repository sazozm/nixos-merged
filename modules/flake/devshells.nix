{ ... }:

{
  perSystem =
    { pkgs, ... }:
    let
      mkCppShell =
        name: buildInputs: shellHook:
        pkgs.mkShell {
          inherit name buildInputs shellHook;
          nativeBuildInputs = with pkgs; [
            cmake
            ninja
            pkg-config
            gcc
            gdb
            lldb
          ];
        };
    in
    {
      devShells = {
        cpp-gui =
          mkCppShell "cpp-gui-dev"
            (with pkgs; [
              raylib
              sfml
              sdl3
              sdl3-image
              sdl3-mixer
              sdl3-ttf
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
            ])
            ''
              export CMAKE_EXPORT_COMPILE_COMMANDS=1
              export QT_QPA_PLATFORM="wayland;xcb"
              echo "C/C++ Dev Environment Loaded (Raylib, SFML, SDL3, Qt6, CMake, Ninja)"
            '';

        cpp-raylib = mkCppShell "cpp-raylib" (with pkgs; [ raylib ]) ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          echo "C++ Raylib dev shell loaded"
        '';

        cpp-sfml = mkCppShell "cpp-sfml" (with pkgs; [ sfml ]) ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          echo "C++ SFML dev shell loaded"
        '';

        cpp-sdl3 =
          mkCppShell "cpp-sdl3"
            (with pkgs; [
              sdl3
              libGL
              wayland
              libx11
              libxcursor
              libxrandr
              libxinerama
              libxi
            ])
            ''
              export CMAKE_EXPORT_COMPILE_COMMANDS=1
              export QT_QPA_PLATFORM="wayland;xcb"
              echo "C++ SDL3 dev shell loaded"
            '';

        cpp-qt6 =
          mkCppShell "cpp-qt6"
            (with pkgs; [
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
            ])
            ''
              export CMAKE_EXPORT_COMPILE_COMMANDS=1
              export QT_QPA_PLATFORM="wayland;xcb"
              echo "C++ Qt6 dev shell loaded"
            '';

        rust-gui = pkgs.mkShell {
          name = "rust-gui-dev";

          nativeBuildInputs = with pkgs; [
            pkg-config
            cargo
            rustc
            rust-analyzer
            clippy
            rustfmt
            cargo-watch
            cargo-edit
            cargo-nextest
          ];

          buildInputs = with pkgs; [
            libGL
            libx11
            libxcursor
            libxrandr
            libxi
            wayland
            libxkbcommon
            fontconfig
            freetype
            alsa-lib
            vulkan-loader
            udev
          ];

          shellHook = ''
            export LD_LIBRARY_PATH="${
              pkgs.lib.makeLibraryPath (
                with pkgs;
                [
                  libGL
                  libx11
                  wayland
                  libxkbcommon
                  fontconfig
                  freetype
                  vulkan-loader
                  alsa-lib
                  udev
                ]
              )
            }:$LD_LIBRARY_PATH"
            echo "Rust Dev Environment Loaded"
          '';
        };
      };
    };
}
