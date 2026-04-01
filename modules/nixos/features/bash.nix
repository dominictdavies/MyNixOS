{ self, ... }:
{
  flake.nixosModules.bash = {
    imports = [
      self.nixosModules.nh
    ];

    programs = {
      bash = {
        enable = true;

        # Functions
        interactiveShellInit = ''
          cpprun() {
            local name="$1"
            shift
            g++ -std=c++23 "''${name}.cpp" -o "''${name}" -lSDL3 &&
            ./"''${name}" "$@"
          }
        '';

        shellAliases = {
          # General
          list = "ls -flA";
          clr = "clear";
          quit = "exit";
          open = "xdg-open";

          # MyNixOS
          mynix-noctalia-push = "(cd ~/MyNixOS/modules/wrappedPrograms/noctalia && nix run nixpkgs#noctalia-shell ipc call state all > noctalia.json && git add noctalia.json && git commit -m \"Update noctalia settings\" && git push)";
          mynix-switch = "nh os switch";
          mynix-pull-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
          mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
          mynix-all-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";

          # Other
          help-keyboard = "open ~/Pictures/Saved/Information/keyboard_layout.png";
          help-vagrant = "open https://cheatography.com/davbfr/cheat-sheets/vagrant-cheat-sheet/";
          help-gdb = "open https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf";
          deltarune = "steam steam://rungameid/1671210 && exit";
        };
      };

      # Environment management depending on current directory
      direnv.enable = true;

      # Command-line fuzzy finder
      fzf.fuzzyCompletion = true;

      # Smarter `cd` command
      zoxide = {
        enable = true;
        flags = [ "--cmd cd" ];
      };

      # Customisable shell prompt
      starship.enable = true;
    };
  };
}
