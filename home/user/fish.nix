{ config, ... }:

let
  c = config.lib.stylix.colors.withHashtag;
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      command_timeout = 150;
      add_newline = true;
      scan_timeout = 10;

      format = ''
        [╭─](bold ${c.base0E}) $username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration
        [╰─](bold ${c.base0E}) $python$rust$nodejs$c$cpp$character
      '';
      right_format = "[$time](${c.base03})";

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold ${c.base0D}";
      };

      git_branch = {
        symbol = " ";
        style = "bold ${c.base0B}";
      };

      git_status = {
        ignore_submodules = true;
        style = "bold ${c.base0A}";
      };

      cmd_duration = {
        min_time = 500;
        style = "bold ${c.base0A}";
        show_milliseconds = false;
      };

      nix_shell = {
        heuristic = true;
        style = "bold ${c.base0C}";
      };

      time = {
        disabled = false;
        format = "󰥔 $time";
        time_format = "%H:%M";
        style = "bold ${c.base03}";
      };

      character = {
        success_symbol = "[❯](bold ${c.base0B})";
        error_symbol = "[❯](bold ${c.base08})";
        vimcmd_symbol = "[❮](bold ${c.base0E})";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
      if test -r /run/secrets/openrouter_api_key
        set -gx OPENROUTER_API_KEY (cat /run/secrets/openrouter_api_key)
      end
    '';

    shellAbbrs = {
      ls = "eza --group-directories-first --color=always";
      ll = "eza -lah --git --group-directories-first --color=always";
      la = "eza -a --group-directories-first --color=always";
      lt = "eza --tree --level=2 --group-directories-first --color=always";
      cl = "clear";
      q = "exit";
      md = "mkdir -p";
      smd = "sudo mkdir -p";
      df = "df -h";
      du = "du -sh";
      free = "free -h";

      connect-phone = "pactl load-module module-null-sink sink_name=scrcpy_mic sink_properties=device.description=\"Pixel_Mic_Input\" ; pactl load-module module-remap-source source_name=scrcpy_mic_source master=scrcpy_mic.monitor source_properties=device.description=\"Pixel_Virtual_Microphone\"";
      start-mic = "scrcpy --audio-source=mic --no-video";

      nv = "nvim";
      snv = "sudo -E nvim";
      shx = "sudo -E hx";

      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gco = "git checkout";
      gcb = "git checkout -b";
      gd = "git diff";
      gs = "git status -sb";
      gl = "git log --oneline --graph --decorate --all";
      gp = "git push";
      gpl = "git pull";

      cg = "cmake -B build -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug";
      cgr = "cmake -B build -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Release";
      nb = "ninja -C build";
      mb = "make -j(nproc)";
      cclean = "rm -rf build";

      cr = "cargo run";
      cb = "cargo build";
      cbr = "cargo build --release";
      ct = "cargo test";
      ck = "cargo check";
      cf = "cargo fmt";
      ccl = "cargo clippy --all-targets --all-features -- -D warnings";
      cw = "cargo watch -x run";
      cnew = "cargo new";

      nix-update = "nh os switch ~/.configs/nixos-merged";
      nix-reb = "nh os switch ~/.configs/nixos-merged";
      nix-test = "nh os test ~/.configs/nixos-merged";
      nix-clean = "nh clean all --keep-since 14d --keep 5";
      demo-secret = "cat /run/secrets/demo";

      fishrc = "$EDITOR ~/.configs/nixos-merged/home/user/fish.nix";
      nix-conf = "$EDITOR ~/.configs/nixos-merged/modules/configurations/nixos/default.nix";
      nix-flake = "$EDITOR ~/.configs/nixos-merged/flake.nix";
      noctalia-conf = "$EDITOR ~/.configs/nixos-merged/home/user/noctalia.nix";
      foot-conf = "$EDITOR ~/.configs/nixos-merged/home/user/foot.nix";
      nixvim-conf = "$EDITOR ~/.configs/nixos-merged/home/user/nixvim.nix";
      mango-conf = "$EDITOR ~/.configs/nixos-merged/home/user/mango.nix";
    };

    shellAliases = {
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
      gccr = "g++ -Wall -Wextra -Wpedantic -fdiagnostics-color";
      fastmake = "cmake -B build -GNinja && ninja -C build";
      nf = "fastfetch";
      sg = "mangohud";
      gs = "gamescope";
      gm = "gamemoderun";
    };

    functions = {
      nr = ''
        ninja -C build; or return 1
        set -l bin (find build -maxdepth 1 -type f -executable | string match -v "*CMake*" | head -n 1)
        if test -n "$bin"
            $bin $argv
        else
            echo "No executable binary found in build/"
            return 1
        end
      '';

      create_raylib_project = ''
                if test (count $argv) -eq 0; echo "Usage: create_raylib_project <name>"; return 1; end
                set -l name $argv[1]
                mkdir -p $name/src
                echo "use flake ~/.configs/nixos-merged#cpp-gui" > $name/.envrc
                echo "cmake_minimum_required(VERSION 3.20)
        project($name LANGUAGES CXX)
        set(CMAKE_CXX_STANDARD 23)
        find_package(raylib REQUIRED)
        add_executable($name src/main.cpp)
        target_link_libraries($name PRIVATE raylib)" > $name/CMakeLists.txt
                echo '#include "raylib.h"
        int main() {
            InitWindow(800, 450, "Raylib");
            while (!WindowShouldClose()) {
                BeginDrawing(); ClearBackground(RAYWHITE); EndDrawing();
            }
            CloseWindow();
        }' > $name/src/main.cpp
      '';

      create_sfml_project = ''
                if test (count $argv) -eq 0; echo "Usage: create_sfml_project <name>"; return 1; end
                set -l name $argv[1]
                mkdir -p $name/src
                echo "use flake ~/.configs/nixos-merged#cpp-gui" > $name/.envrc
                echo "cmake_minimum_required(VERSION 3.20)
        project($name LANGUAGES CXX)
        set(CMAKE_CXX_STANDARD 23)
        find_package(SFML 2.6 COMPONENTS graphics window system REQUIRED)
        add_executable($name src/main.cpp)
        target_link_libraries($name PRIVATE sfml-graphics sfml-window sfml-system)" > $name/CMakeLists.txt
                echo '#include <SFML/Graphics.hpp>
        int main() {
            sf::RenderWindow window(sf::VideoMode(800, 600), "SFML");
            while (window.isOpen()) {
                sf::Event event;
                while (window.pollEvent(event)) { if (event.type == sf::Event::Closed) window.close(); }
                window.clear(); window.display();
            }
        }' > $name/src/main.cpp
      '';

      create_sdl_project = ''
                if test (count $argv) -eq 0; echo "Usage: create_sdl_project <name>"; return 1; end
                set -l name $argv[1]
                mkdir -p $name/src
                echo "use flake ~/.configs/nixos-merged#cpp-gui" > $name/.envrc
                echo "cmake_minimum_required(VERSION 3.20)
        project($name LANGUAGES CXX)
        set(CMAKE_CXX_STANDARD 23)
        find_package(SDL3 REQUIRED)
        add_executable($name src/main.cpp)
        target_link_libraries($name PRIVATE SDL3::SDL3)" > $name/CMakeLists.txt
                echo '#include <SDL3/SDL.h>
        int main() {
            SDL_Init(SDL_INIT_VIDEO);
            SDL_Window* window = SDL_CreateWindow("SDL3", 800, 600, 0);
            SDL_Event event; bool running = true;
            while (running) {
                while (SDL_PollEvent(&event)) { if (event.type == SDL_EVENT_QUIT) running = false; }
            }
            SDL_DestroyWindow(window);
            SDL_Quit();
            return 0;
        }' > $name/src/main.cpp
      '';

      create_qt6_project = ''
                if test (count $argv) -eq 0; echo "Usage: create_qt6_project <name>"; return 1; end
                set -l name $argv[1]
                mkdir -p $name/src
                echo "use flake ~/.configs/nixos-merged#cpp-gui" > $name/.envrc
                echo "cmake_minimum_required(VERSION 3.20)
        project($name LANGUAGES CXX)
        set(CMAKE_CXX_STANDARD 20)
        set(CMAKE_AUTOMOC ON)
        find_package(Qt6 REQUIRED COMPONENTS Widgets)
        add_executable($name src/main.cpp)
        target_link_libraries($name PRIVATE Qt6::Widgets)" > $name/CMakeLists.txt
                echo '#include <QApplication>
        #include <QPushButton>
        int main(int argc, char *argv[]) {
            QApplication app(argc, argv);
            QPushButton button("Hello Qt6!");
            button.show();
            return app.exec();
        }' > $name/src/main.cpp
      '';

      mango = "exec mango";

      mkcd = "mkdir -p $argv[1]; and cd $argv[1]";

      bak = ''
        cp $argv[1] $argv[1].bak; and echo "✓ backed up: $argv[1].bak"
      '';

      up = ''
        set -l n 1
        if test (count $argv) -gt 0
            set n $argv[1]
        end
        cd (string repeat -n $n ../)
      '';

      build_c_raylib = ''
        if test (count $argv) -eq 0; echo "Usage: build_c_raylib <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            gcc -std=c11 -O2 $argv[1] (pkg-config --cflags --libs raylib) -o $out
        else
            nix-shell -p coreutils gcc pkg-config raylib --run "gcc -std=c11 -O2 $argv[1] \$(pkg-config --cflags --libs raylib) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_c_raylib = ''
        if test (count $argv) -eq 0; echo "Usage: run_c_raylib <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_c_raylib $argv[1]; and ./$out
      '';

      build_cpp_raylib = ''
        if test (count $argv) -eq 0; echo "Usage: build_cpp_raylib <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            g++ -std=c++23 -O2 $argv[1] (pkg-config --cflags --libs raylib) -o $out
        else
            nix-shell -p coreutils gcc pkg-config raylib --run "g++ -std=c++23 -O2 $argv[1] \$(pkg-config --cflags --libs raylib) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_cpp_raylib = ''
        if test (count $argv) -eq 0; echo "Usage: run_cpp_raylib <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_cpp_raylib $argv[1]; and ./$out
      '';

      build_c_sdl = ''
        if test (count $argv) -eq 0; echo "Usage: build_c_sdl <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            gcc -std=c11 -O2 $argv[1] (pkg-config --cflags --libs sdl3) -o $out
        else
            nix-shell -p coreutils gcc pkg-config SDL3 --run "gcc -std=c11 -O2 $argv[1] \$(pkg-config --cflags --libs sdl3) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_c_sdl = ''
        if test (count $argv) -eq 0; echo "Usage: run_c_sdl <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_c_sdl $argv[1]; and ./$out
      '';

      build_cpp_sdl = ''
        if test (count $argv) -eq 0; echo "Usage: build_cpp_sdl <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            g++ -std=c++23 -O2 $argv[1] (pkg-config --cflags --libs sdl3) -o $out
        else
            nix-shell -p coreutils gcc pkg-config SDL3 --run "g++ -std=c++23 -O2 $argv[1] \$(pkg-config --cflags --libs sdl3) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_cpp_sdl = ''
        if test (count $argv) -eq 0; echo "Usage: run_cpp_sdl <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_cpp_sdl $argv[1]; and ./$out
      '';

      build_cpp_sfml = ''
        if test (count $argv) -eq 0; echo "Usage: build_cpp_sfml <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            g++ -std=c++23 -O2 $argv[1] (pkg-config --cflags --libs sfml-all) -o $out
        else
            nix-shell -p coreutils gcc pkg-config sfml --run "g++ -std=c++23 -O2 $argv[1] \$(pkg-config --cflags --libs sfml-all) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_cpp_sfml = ''
        if test (count $argv) -eq 0; echo "Usage: run_cpp_sfml <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_cpp_sfml $argv[1]; and ./$out
      '';

      build_c_sfml = ''
        if test (count $argv) -eq 0; echo "Usage: build_c_sfml <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            gcc -std=c11 -O2 $argv[1] (pkg-config --cflags --libs csfml-all) -o $out
        else
            nix-shell -p coreutils gcc pkg-config csfml --run "gcc -std=c11 -O2 $argv[1] \$(pkg-config --cflags --libs csfml-all) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_c_sfml = ''
        if test (count $argv) -eq 0; echo "Usage: run_c_sfml <file.c>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_c_sfml $argv[1]; and ./$out
      '';

      build_qt = ''
        if test (count $argv) -eq 0; echo "Usage: build_qt <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        if set -q PKG_CONFIG_PATH
            g++ -std=c++20 -fPIC $argv[1] (pkg-config --cflags --libs Qt6Widgets Qt6Core) -o $out
        else
            nix-shell -p coreutils gcc pkg-config kdePackages.qtbase --run "g++ -std=c++20 -fPIC $argv[1] \$(pkg-config --cflags --libs Qt6Widgets Qt6Core) -o $out"
        end
        and echo "Build successful: ./$out"
      '';

      run_qt = ''
        if test (count $argv) -eq 0; echo "Usage: run_qt <file.cpp>"; return 1; end
        set -l out (string replace -r '\.[^.]+$' "" $argv[1])
        build_qt $argv[1]; and ./$out
      '';

      fcd = ''
        set dir (fd --type d --hidden --exclude .git | fzf --prompt='cd ❯ ')
        if test -n "$dir"
            cd $dir
        end
      '';

      fkill = ''
        set pid (ps aux | tail -n +2 | fzf --prompt='kill ❯ ' | awk '{print $2}')
        if test -n "$pid"
            kill -9 $pid && echo "killed PID $pid"
        end
      '';

      gbf = ''
        set branch (git branch --all | grep -v HEAD | fzf --prompt='branch ❯ ' | string replace -r 'remotes/origin/' "")
        if test -n "$branch"
            git checkout $branch
        end
      '';

      fnvim = ''
        set file (fd --type f --hidden --exclude .git | fzf --prompt='nvim ❯ ')
        if test -n "$file"
            nvim $file
        end
      '';

      glog = ''
        git log --oneline --color=always $argv | fzf --ansi --no-sort --reverse \
            --preview 'git show --stat --color=always {1}' \
            --prompt='log ❯ ' --bind 'enter:execute(git show --color=always {1} | bat --color=always -l diff)'
      '';
    };
  };
}
