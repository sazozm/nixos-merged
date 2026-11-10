{
  description = "C++ SFML project template";

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
        name = "cpp-sfml";

        nativeBuildInputs = with pkgs; [
          cmake
          ninja
          pkg-config
          gcc
          gdb
          lldb
        ];

        buildInputs = with pkgs; [
          sfml
        ];

        shellHook = ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1
          echo "C++ SFML dev shell loaded"
        '';
      };
    };
}
