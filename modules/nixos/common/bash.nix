{ self, ... }:
{
  flake.nixosModules.common = {
    programs = {
      bash = {
        enable = true;

        shellAliases = {
          # General
          list = "ls -flA";
          clr = "clear";

          # MyNixOS
          mynix-switch = "nh os switch";
          mynix-pull-switch = "(cd ~/MyNixOS && git pull && nh os switch)";
          mynix-flake-switch = "(cd ~/MyNixOS && nix flake update && nh os switch)";
          mynix-all-switch = "(cd ~/MyNixOS && git pull && nix flake update && nh os switch)";
        };
      };

      # NixOS CLI helper
      nh = {
        enable = true;
        flake = "/etc/nixos";
      };

      # Command-line fuzzy finder
      fzf.fuzzyCompletion = true;

      # Smarter `cd` command
      zoxide = {
        enable = true;
        flags = [
          "--no-cmd"
          "--cmd cd"
        ];
      };

      # Customisable shell prompt
      starship.enable = true;

      # Environment management depending on current directory
      direnv.enable = true;
    };
  };
}
