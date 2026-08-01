{ self, ... }:
{
  flake.nixosModules.common =
    { config, ... }:
    {
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
            mynix-pull = "(cd ${config.my.repoRoot} && git pull --rebase)";
            mynix-pull-switch = "mynix-pull && mynix-switch";
            mynix-pull-boot = "mynix-pull && mynix-boot";
            mynix-flake = "(cd ${config.my.repoRoot} && nix flake update && git add flake.lock && git commit -m \"Update flake\" && git push)";
            mynix-flake-switch = "mynix-flake && mynix-switch";
            mynix-flake-boot = "mynix-flake && mynix-boot";
            mynix-all-switch = "mynix-pull && mynix-flake && mynix-switch";
            mynix-all-boot = "mynix-pull && mynix-flake && mynix-boot";

            # Shells
            shell = "cp ${config.my.repoRoot}/shells/shell.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
            shell-python = "cp ${config.my.repoRoot}/shells/python.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
            shell-rust = "cp ${config.my.repoRoot}/shells/rust.nix ./shell.nix && echo use nix > .envrc && direnv allow .";
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
