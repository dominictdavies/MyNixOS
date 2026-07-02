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
          # MyNixOS
          mynix-switch = "nh os switch";
          mynix-boot = "nh os boot";
          mynix-pull = "(cd ~/MyNixOS && git pull --rebase)";
          mynix-pull-switch = "mynix-pull && mynix-switch";
          mynix-pull-boot = "mynix-pull && mynix-boot";
          mynix-update = "(cd ~/MyNixOS && nix flake update && git add flake.lock && git commit -m \"Update flake\" && git push)";
          mynix-update-switch = "mynix-update && mynix-switch";
          mynix-update-boot = "mynix-update && mynix-boot";
          mynix-all-switch = "mynix-pull && mynix-update && mynix-switch";
          mynix-all-boot = "mynix-pull && mynix-update && mynix-boot";

          # Shells
          shell = "cp ~/MyNixOS/shells/shell.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
          shell-python = "cp ~/MyNixOS/shells/python.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
          shell-rust = "cp ~/MyNixOS/shells/rust.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
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
