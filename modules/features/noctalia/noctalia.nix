{ inputs, self, ... }:
{
  flake.nixosModules.noctalia =
    { pkgs, config, ... }:
    {
      # Noctalia (https://docs.noctalia.dev/v5/configuration)
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

        # Required by scripts
        pkgs.jo
      ];

      environment.sessionVariables.NOCTALIA_CONFIG_HOME = "$HOME/MyNixOS/modules/features/";

      programs.bash.shellAliases = {
        mynix-noctalia = "(cd ${config.my.repoRoot}/modules/features/noctalia && noctalia config export merged > config.toml && git add config.toml && git commit -m \"Update noctalia\" && git push)";
        mynix-noctalia-switch = "mynix-noctalia && noctalia msg config-reload";
      };
    };
}
