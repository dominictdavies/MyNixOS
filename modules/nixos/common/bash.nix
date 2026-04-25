{ self, ... }:
{
  flake.nixosModules.common = {
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

          # Languages
          rust = "nix-shell -p rustup";
          cpp = "nix-shell -p gcc cgdb";

          # MyNixOS
          mynix-pull = "(cd ~/MyNixOS && git pull --rebase)";
          mynix-switch = "nh os switch";
          mynix-pull-switch = "mynix-pull && mynix-switch";
          mynix-update = "(cd ~/MyNixOS && git pull --rebase && nix flake update && git add flake.lock && git commit -m \"Update flake\" && git push)";
          mynix-update-switch = "mynix-update && mynix-switch";
          mynix-all-switch = "mynix-pull && mynix-update && mynix-switch";
        };
      };

      # Environment management depending on current directory
      direnv.enable = true;

      # Command-line fuzzy finder
      fzf.fuzzyCompletion = true;

      # Smarter `cd` command
      zoxide = {
        enable = true;
        flags = [
          "--cmd cd"
        ];
      };

      # Customisable shell prompt
      starship.enable = true;
    };

    # Prevent zoxide warning
    environment.sessionVariables._ZO_DOCTOR = 0;
  };
}
