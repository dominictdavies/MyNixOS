{ self, inputs, ... }:
{
  flake.nixosModules.bash =
    { ... }:
    {
      programs.bash = {
        enable = true;

        shellAliases = {
          # General
          list = "ls -flA";
          clr = "clear";
          quit = "exit";
          open = "xdg-open";

          # MyNixOS
          mynix-switch = "nh os switch";
          mynix-sync-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
          mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
          mynix-full-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch && git add flake.lock && git commit -m \"Update flake\" && git push)";
        };
      };
    };
}
