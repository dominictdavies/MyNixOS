{ self, inputs, ... }:
{
  flake.nixosModules.bash =
    {
      imports = [
        self.nixosModules.nh
      ];

      programs = {
        bash = {
          enable = true;

          shellAliases = {
            # General
            list = "ls -flA";
            clr = "clear";
            quit = "exit";
            open = "xdg-open";

            # MyNixOS
            mynix-push-noctalia = "(cd ~/MyNixOS/modules/wrappedPrograms/noctalia && nix run nixpkgs#noctalia-shell ipc call state all > noctalia.json && git add noctalia.json && git commit -m \"Update noctalia settings\" && git push)";
            mynix-switch = "nh os switch";
            mynix-pull-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
            mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
            mynix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
          };
        };

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
