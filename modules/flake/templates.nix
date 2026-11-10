{ self, ... }:

{
  flake.templates = {
    rust-gui = {
      path = "${self}/templates/rust-gui";
      description = "Rust dev";
    };
    cpp-gui = {
      path = "${self}/templates/cpp-gui";
      description = "C++ GUI dev (Raylib, SFML, SDL2/3, Qt6)";
    };
    cpp-raylib = {
      path = "${self}/templates/cpp-raylib";
      description = "C++ Raylib project";
    };
    cpp-sfml = {
      path = "${self}/templates/cpp-sfml";
      description = "C++ SFML project";
    };
    cpp-sdl3 = {
      path = "${self}/templates/cpp-sdl3";
      description = "C++ SDL3 project";
    };
    cpp-qt6 = {
      path = "${self}/templates/cpp-qt6";
      description = "C++ Qt6 project";
    };
  };
}
