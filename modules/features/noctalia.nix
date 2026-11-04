{ inputs, ... }:
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

      environment.sessionVariables.NOCTALIA_CONFIG_HOME = "${config.my.repoRoot}/dotfiles/";
    };
}
