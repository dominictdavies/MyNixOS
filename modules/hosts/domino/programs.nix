{ ... }:

{
  programs = {
    bash = {
      enable = true;

      shellAliases = {
        # General
        list = "ls -flA";
        clr = "clear";
        quit = "exit";

        # NixOS
        mynix-switch = "nh os switch";
        mynix-sync-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
        mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
        mynix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";

        # Domino
        open = "xdg-open";
        help-keyboard = "open ~/Pictures/Saved/Information/keyboard_layout.png";
        help-vagrant = "open https://cheatography.com/davbfr/cheat-sheets/vagrant-cheat-sheet/";
        help-gdb = "open https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf";
        deltarune = "steam steam://rungameid/1671210 && exit";
      };

      interactiveShellInit = ''
        cpprun() {
          local name="$1"
          shift
          g++ -std=c++23 "''${name}.cpp" -o "''${name}" -lSDL3 &&
          ./"''${name}" "$@"
        }
      '';
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

    # Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
