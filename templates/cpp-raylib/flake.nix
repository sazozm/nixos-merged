{
  description = "C++ Raylib project template";

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
        name = "cpp-raylib";

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
          gcc
          gdb
          lldb
        ];

        buildInputs = with pkgs; [
          raylib
        ];

        shellHook = ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          echo "C++ Raylib dev shell loaded"
        '';
      };
    };
}
